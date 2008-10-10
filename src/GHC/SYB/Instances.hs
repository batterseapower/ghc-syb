{- | "GHC.Syb.Instances" provides instances of Data\/Typeable
     for Ghc Api types, using standalone deriving.

Most instances are standard; to provide 'Data' instances 
abstract types, we use one of two schemes:

- no traversal: 'SrcSpan', 'Module', 'ModuleName', 'OccName', 'Name', 
                'FastString', 'DataCon', 'Var', 'TyCon', 'Class'

@
    abstractConstr   n = mkConstr (abstractDataType n) ("{abstract:"++n++"}") [] Prefix
    abstractDataType n = mkDataType n [abstractConstr n]
@

@
    instance Data SrcSpan where
      -- don't traverse?
      toConstr _   = abstractConstr "SrcSpan"
      gunfold _ _  = error "gunfold"
      dataTypeOf _ = mkNorepType "SrcSpan"
@

- abstract traversal: 'NameSet', 'Bag'

@
    instance Data NameSet where
      gfoldl k z s = z mkNameSet `k` nameSetToList s -- traverse abstractly
      toConstr _   = abstractConstr "NameSet"
      gunfold _ _  = error "gunfold"
      dataTypeOf _ = mkNorepType "NameSet"
@

Please report any issues, either with these abstract instances or with
these modules going out of sync with GHC head, to the package maintainer.

-}
module GHC.SYB.Instances where

import GHC hiding(TyCon)
import SrcLoc
import RdrName
import OccName
import FastString
import Bag
import Module
import BasicTypes
import Var
import ForeignCall

import Data.Data
import NameSet
import TypeRep
import qualified TyCon

#include "Typeable.h"

#ifdef __HADDOCK__
#else

-- TODO: good for generalized show, but is this sound in general?
abstractConstr   n = mkConstr (abstractDataType n) ("{abstract:"++n++"}") [] Prefix
abstractDataType n = mkDataType n [abstractConstr n]

-- Typeable0

INSTANCE_TYPEABLE0(SrcSpan,srcSpanTc,"SrcSpan")
instance Data SrcSpan where
  -- don't traverse?
  toConstr _   = abstractConstr "SrcSpan"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "SrcSpan"

INSTANCE_TYPEABLE0(Module,moduleTc,"Module")
instance Data Module where
  -- don't traverse?
  toConstr _   = abstractConstr "Module"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "Module"

INSTANCE_TYPEABLE0(ModuleName,moduleNameTc,"ModuleName")
instance Data ModuleName where
  -- don't traverse?
  toConstr _   = abstractConstr "ModuleName"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "ModuleName"

deriving instance Typeable RdrName
deriving instance Data RdrName

INSTANCE_TYPEABLE0(OccName,occNameTc,"OccName")
instance Data OccName where
  -- don't traverse?
  toConstr _   = abstractConstr "OccName"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "OccName"

INSTANCE_TYPEABLE0(Name,nameTc,"Name")
instance Data Name where
  -- don't traverse?
  toConstr _   = abstractConstr "Name"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "Name"

deriving instance Typeable FastString
instance Data FastString where
  -- don't traverse?
  toConstr _   = abstractConstr "FastString"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "FastString"

deriving instance Typeable HsExplicitForAll
deriving instance Data HsExplicitForAll

deriving instance Typeable HsBang
deriving instance Data HsBang

deriving instance Typeable Boxity
deriving instance Data Boxity

deriving instance Typeable OverLitVal
deriving instance Data OverLitVal

deriving instance Typeable RecFlag
deriving instance Data RecFlag

deriving instance Typeable BasicTypes.Fixity
deriving instance Data BasicTypes.Fixity

deriving instance Typeable HsArrAppType
deriving instance Data HsArrAppType

deriving instance Typeable FixityDirection
deriving instance Data FixityDirection

INSTANCE_TYPEABLE0(DataCon,dataConTc,"DataCon")
instance Data DataCon where
  -- don't traverse?
  toConstr _   = abstractConstr "DataCon"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "DataCon"

INSTANCE_TYPEABLE0(Var,varTc,"Var")
instance Data Var where
  -- don't traverse?
  toConstr _   = abstractConstr "Var"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "Var"

deriving instance Typeable InlineSpec
deriving instance Data InlineSpec

deriving instance Typeable ForeignImport
deriving instance Data ForeignImport

deriving instance Typeable ForeignExport
deriving instance Data ForeignExport

deriving instance Typeable CImportSpec
deriving instance Data CImportSpec

deriving instance Typeable CExportSpec
deriving instance Data CExportSpec

deriving instance Typeable DNCallSpec
deriving instance Data DNCallSpec

deriving instance Typeable Safety
deriving instance Data Safety

deriving instance Typeable CCallConv
deriving instance Data CCallConv

deriving instance Typeable DNKind
deriving instance Data DNKind

deriving instance Typeable DNType
deriving instance Data DNType

deriving instance Typeable CCallTarget
deriving instance Data CCallTarget

deriving instance Typeable Activation
deriving instance Data Activation

INSTANCE_TYPEABLE0(NameSet,nameSetTc,"NameSet")
instance Data NameSet where
  gfoldl k z s = z mkNameSet `k` nameSetToList s -- traverse abstractly
  toConstr _   = abstractConstr "NameSet"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "NameSet"

deriving instance Typeable FoType
deriving instance Data FoType

deriving instance Typeable FamilyFlavour
deriving instance Data FamilyFlavour

deriving instance Typeable NewOrData
deriving instance Data NewOrData

INSTANCE_TYPEABLE0(TyCon.TyCon,tyConTc,"TyCon")
instance Data TyCon.TyCon where
  -- don't traverse?
  toConstr _   = abstractConstr "TyCon.TyCon"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "TyCon.TyCon"

INSTANCE_TYPEABLE0(Class,classTc,"Class")
instance Data Class where
  -- don't traverse?
  toConstr _   = abstractConstr "Class"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "Class"

deriving instance Typeable Prag
deriving instance Data Prag

deriving instance Typeable HsWrapper
deriving instance Data HsWrapper

deriving instance Typeable PredType
deriving instance Data PredType

deriving instance Typeable Type
deriving instance Data Type

deriving instance Typeable HsLit
deriving instance Data HsLit

-- Typeable1

deriving instance Typeable1 Located
deriving instance Data e => Data (Located e)

deriving instance Typeable1 HsModule
deriving instance Data a => Data (HsModule a)

deriving instance Typeable1 HsDoc
deriving instance Data a => Data (HsDoc a)

deriving instance Typeable1 HaddockModInfo
deriving instance Data a => Data (HaddockModInfo a)

deriving instance Typeable1 HsDecl
deriving instance Data a => Data (HsDecl a)

deriving instance Typeable1 ImportDecl
deriving instance Data a => Data (ImportDecl a)

deriving instance Typeable1 IE
deriving instance Data a => Data (IE a)

deriving instance Typeable1 TyClDecl
deriving instance Data a => Data (TyClDecl a)

deriving instance Typeable1 DocDecl
deriving instance Data a => Data (DocDecl a)

deriving instance Typeable1 SpliceDecl
deriving instance Data a => Data (SpliceDecl a)

deriving instance Typeable1 RuleDecl
deriving instance Data a => Data (RuleDecl a)

deriving instance Typeable WarningTxt
deriving instance Data WarningTxt

deriving instance Typeable1 WarnDecl
deriving instance Data a => Data (WarnDecl a)

deriving instance Typeable1 ForeignDecl
deriving instance Data a => Data (ForeignDecl a)

deriving instance Typeable1 DefaultDecl
deriving instance Data a => Data (DefaultDecl a)

deriving instance Typeable1 Sig
deriving instance Data a => Data (Sig a)

deriving instance Typeable1 DerivDecl
deriving instance Data a => Data (DerivDecl a)

deriving instance Typeable1 InstDecl
deriving instance Data a => Data (InstDecl a)

deriving instance Typeable1 HsPred
deriving instance Data a => Data (HsPred a)

deriving instance Typeable1 HsType
deriving instance Data a => Data (HsType a)

deriving instance Typeable1 ConDecl
deriving instance Data a => Data (ConDecl a)

INSTANCE_TYPEABLE1(Bag,bagTc,"Bag")
instance Data a => Data (Bag a) where
  gfoldl k z b = z listToBag `k` bagToList b -- traverse abstract type abstractly
  toConstr _   = abstractConstr $ "Bag("++show (typeOf (undefined::a))++")"
  gunfold _ _  = error "gunfold"
  dataTypeOf _ = mkNorepType "Bag"

deriving instance Typeable1 HsTyVarBndr
deriving instance Data a => Data (HsTyVarBndr a)

deriving instance Typeable1 ResType
deriving instance Data a => Data (ResType a)

deriving instance Typeable1 HsSplice
deriving instance Data a => Data (HsSplice a)

deriving instance Typeable1 ConDeclField
deriving instance Data a => Data (ConDeclField a)

deriving instance Typeable1 IPName
deriving instance Data a => Data (IPName a)

deriving instance Typeable1 MatchGroup
deriving instance Data a => Data (MatchGroup a)

deriving instance Typeable1 Pat
deriving instance Data a => Data (Pat a)

deriving instance Typeable1 GRHSs
deriving instance Data a => Data (GRHSs a)

deriving instance Typeable1 HsExpr
deriving instance Data a => Data (HsExpr a)

deriving instance Typeable1 HsQuasiQuote
deriving instance Data a => Data (HsQuasiQuote a)

deriving instance Typeable1 HsOverLit
deriving instance Data a => Data (HsOverLit a)

deriving instance Typeable1 ArithSeqInfo
deriving instance Data a => Data (ArithSeqInfo a)

deriving instance Typeable1 HsBracket
deriving instance Data a => Data (HsBracket a)

deriving instance Typeable1 HsCmdTop
deriving instance Data a => Data (HsCmdTop a)

deriving instance Typeable1 HsGroup
deriving instance Data a => Data (HsGroup a)

deriving instance Typeable1 FixitySig
deriving instance Data a => Data (FixitySig a)

deriving instance Typeable1 HsIPBinds
deriving instance Data a => Data (HsIPBinds a)

deriving instance Typeable1 IPBind
deriving instance Data a => Data (IPBind a)

deriving instance Typeable1 GroupByClause
deriving instance Data a => Data (GroupByClause a)

deriving instance Typeable1 HsStmtContext
deriving instance Data a => Data (HsStmtContext a)

deriving instance Typeable1 HsMatchContext
deriving instance Data a => Data (HsMatchContext a)

deriving instance Typeable1 GRHS
deriving instance Data a => Data (GRHS a)

deriving instance Typeable1 Match
deriving instance Data a => Data (Match a)

deriving instance Typeable1 RuleBndr
deriving instance Data a => Data (RuleBndr a)

-- Typeable2

deriving instance Typeable2 HsBindLR
deriving instance (Data a,Data b) => Data (HsBindLR a b)

deriving instance Typeable2 StmtLR
deriving instance (Data a,Data b) => Data (StmtLR a b)

deriving instance Typeable2 HsLocalBindsLR
deriving instance (Data a,Data b) => Data (HsLocalBindsLR a b)

deriving instance Typeable2 HsValBindsLR
deriving instance (Data a,Data b) => Data (HsValBindsLR a b)

deriving instance Typeable2 HsConDetails
deriving instance (Data a,Data b) => Data (HsConDetails a b)

deriving instance Typeable2 HsRecFields
deriving instance (Data a,Data b) => Data (HsRecFields a b)

deriving instance Typeable2 HsRecField
deriving instance (Data a,Data b) => Data (HsRecField a b)

#endif 

