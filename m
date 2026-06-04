Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D33BFAF2;
	Thu,  4 Jun 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601108; cv=none; b=N0AJr6aJiEyWK/BeDP/W4mdH9kc13F+hy9qmZiHOR1Cp5y9mSGQvkVC9TeiOH3ZOBSir0gX9Pi5RTbORavwuSjhKUzGM5ReuLJSLPUJNuMO8yzbPIdmkUwNWq1Pjg4SrylOcq2Yda1fEB6l8bVKF7ZIJKRVw0Jmpi0Au7bqqH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601108; c=relaxed/simple;
	bh=0a5DVrgepYEO8hAbzYE40hxpit13P21FDRQPl4sUCus=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o8M/c3amImDiWv97eS7lDG5DXJ+jMvc2/lfa6sYKvjZ3v6hQPeR/0GR9870GrEYyjXff8VAQCXIuxMyYD7ag03sQkrQoaMz5wpHabM3eTncS8gE53Nsp7M2ZlcBxZgiOJTJYHE4k2lsGSvAMdLM0MKCbxj9ErhF/dLALZYQextk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyXuq/MB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyXuq/MB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780601106; x=1812137106;
  h=date:from:to:cc:subject:message-id;
  bh=0a5DVrgepYEO8hAbzYE40hxpit13P21FDRQPl4sUCus=;
  b=OyXuq/MBKHcp43ISXPmux9B88kT9ixqbjwsrc9eI+pP01JP0E8PFhdMi
   ItKzFQMLgDHFRwKVo3/v8VzuQV91cBVu3/DElrzcZkEXP4DWnHtHCaTm1
   /LwMRzCeHMHyl8LCmVDddORdAKiXR1wb+cCPFBVOVhXIknGYYG6ahhyz0
   wfRPLTMEcRZnbIPyHZ9MQKrctbRRs+v+0ux7ZA3lU3zjM7J0wvi+Twtbp
   +drTT0vHcsUQik0AycBxAJ0svIhsoodg53U87CHWDJsU2cAFXcn3nhW8y
   XhziyLiejta8t6uoyrK2BlnNGh1d/3NzNzpd0olt5UQK9YvJpn4EnYjzC
   g==;
X-CSE-ConnectionGUID: TPc6qx6SRjm1a6D06hocAQ==
X-CSE-MsgGUID: TfExWGbERYGx5cY1FeWVOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92919038"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92919038"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:25:04 -0700
X-CSE-ConnectionGUID: RgJs0L04Swq6GpkNbchEJg==
X-CSE-MsgGUID: 8sqwgQfeRFmgvkLpu6GyRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274883393"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 04 Jun 2026 12:25:03 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVDga-000000002NX-3Ja3;
	Thu, 04 Jun 2026 19:25:00 +0000
Date: Thu, 04 Jun 2026 21:24:29 +0200
From: kernel test robot <lkp@intel.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev
Subject: [mptcp:export 6/52]
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1236:20: error: 'Scratch'
 undeclared; did you mean 'watch'?
Message-ID: <202606042103.IiGEqrkc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

tree:   https://github.com/multipath-tcp/mptcp_net-next.git export
head:   0b9943d992a58cba5698da432d2e534c7a298222
commit: f1ebf077eaba4bb12d44417d6d27fca8f2bbc0f1 [6/52] TopGit-driven merge of branches:
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260604/202606042103.IiGEqrkc-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606042103.IiGEqrkc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606042103.IiGEqrkc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/pcie/drv.c: In function '_iwl_pci_resume':
>> drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1236:20: error: 'Scratch' undeclared (first use in this function); did you mean 'watch'?
    1236 |                  * Scratch value was altered, this means the device was powered
         |                    ^~~~~~~
         |                    watch
   drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1236:20: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1236:27: error: expected ';' before 'value'
    1236 |                  * Scratch value was altered, this means the device was powered
         |                           ^~~~~~
         |                           ;


vim +1236 drivers/net/wireless/intel/iwlwifi/pcie/drv.c

48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1212  
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1213  static int _iwl_pci_resume(struct device *device, bool restore)
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1214  {
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1215  	struct pci_dev *pdev = to_pci_dev(device);
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1216  	struct iwl_trans *trans = pci_get_drvdata(pdev);
fa9f3281cbb107 drivers/net/wireless/iwlwifi/pcie/drv.c       Emmanuel Grumbach      2015-06-11  1217  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1218  	bool device_was_powered_off = false;
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1219  
b09b296dddde09 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-07-11  1220  	/* Before you put code here, think about WoWLAN. You cannot check here
b09b296dddde09 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-07-11  1221  	 * whether WoWLAN is enabled or not, and your code will run even if
b09b296dddde09 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-07-11  1222  	 * WoWLAN is enabled - the NIC may be alive.
b09b296dddde09 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-07-11  1223  	 */
b09b296dddde09 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-07-11  1224  
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1225  	/*
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1226  	 * We disable the RETRY_TIMEOUT register (0x41) to keep
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1227  	 * PCI Tx retries from interfering with C3 CPU state.
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1228  	 */
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1229  	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1230  
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1231  	if (!trans->op_mode)
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1232  		return 0;
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1233  
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1234  	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
f1ebf077eaba4b drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matthieu Baerts (NGI0  2026-06-04  1235) 		*
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31 @1236  		 * Scratch value was altered, this means the device was powered
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1237  		 * off, we need to reset it completely.
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1238  		 * Note: MAC (bits 0:7) will be cleared upon suspend even with
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1239  		 * wowlan, but not bits [15:8]. So if we have bits set in lower
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1240  		 * word, assume the device is alive.
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1241  		 * Alternatively, if the scratch value is 0xFFFFFFFF, then we
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1242  		 * no longer have access to the device and consider it powered
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1243  		 * off.
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1244  		 * For older devices, just try silently to grab the NIC.
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1245  		 */
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1246  		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
224476613c8499 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-08-28  1247  			u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
224476613c8499 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-08-28  1248  
224476613c8499 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-08-28  1249  			if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
e2323929a68af0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Aaron Katzin           2026-05-12  1250  			    scratch == ~0U) {
e2323929a68af0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Aaron Katzin           2026-05-12  1251  				IWL_DEBUG_WOWLAN(trans,
e2323929a68af0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Aaron Katzin           2026-05-12  1252  						 "Scratch 0x%08x indicates device was powered off\n",
e2323929a68af0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Aaron Katzin           2026-05-12  1253  						 scratch);
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1254  				device_was_powered_off = true;
e2323929a68af0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Aaron Katzin           2026-05-12  1255  			}
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1256  		} else {
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1257  			/*
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1258  			 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1259  			 * so re-enable them if _iwl_trans_pcie_grab_nic_access
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1260  			 * fails.
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1261  			 */
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1262  			local_bh_disable();
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1263  			if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1264  				iwl_trans_pcie_release_nic_access(trans);
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1265  			} else {
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1266  				device_was_powered_off = true;
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1267  				local_bh_enable();
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1268  			}
6a0f81c549a00f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2025-06-03  1269  		}
093305d801fae6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2026-05-31  1270  	}
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1271  
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1272  	if (restore || device_was_powered_off) {
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1273  		trans->state = IWL_TRANS_NO_FW;
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1274  		/* Hope for the best here ... If one of those steps fails we
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1275  		 * won't really know how to recover.
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1276  		 */
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1277  		iwl_pcie_prepare_card_hw(trans);
da4234c0c4057f drivers/net/wireless/intel/iwlwifi/pcie/drv.c Miri Korenblit         2025-09-09  1278  		iwl_trans_activate_nic(trans);
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1279  		iwl_op_mode_device_powered_off(trans->op_mode);
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1280  	}
cb347bd29d0d10 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2024-08-25  1281  
f98ad635c097c2 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2018-03-13  1282  	/* In WOWLAN, let iwl_trans_pcie_d3_resume do the rest of the work */
f98ad635c097c2 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2018-03-13  1283  	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
f98ad635c097c2 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2018-03-13  1284  		return 0;
f98ad635c097c2 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Emmanuel Grumbach      2018-03-13  1285  
52848a79b9d2d6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-06-20  1286  	/* reconfigure the MSI-X mapping to get the correct IRQ for rfkill */
52848a79b9d2d6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-06-20  1287  	iwl_pcie_conf_msix_hw(trans_pcie);
52848a79b9d2d6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-06-20  1288  
54154618b5633a drivers/net/wireless/iwlwifi/pcie/drv.c       Eliad Peller           2015-05-28  1289  	/*
326477e4858cd6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-04-25  1290  	 * Enable rfkill interrupt (in order to keep track of the rfkill
326477e4858cd6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-04-25  1291  	 * status). Must be locked to avoid processing a possible rfkill
9ad8fd0b4a24e6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-06-20  1292  	 * interrupt while in iwl_pcie_check_hw_rf_kill().
54154618b5633a drivers/net/wireless/iwlwifi/pcie/drv.c       Eliad Peller           2015-05-28  1293  	 */
23aeea943b4660 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2016-12-13  1294  	mutex_lock(&trans_pcie->mutex);
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1295  	iwl_enable_rfkill_int(trans);
9ad8fd0b4a24e6 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg          2017-06-20  1296  	iwl_pcie_check_hw_rf_kill(trans);
fa9f3281cbb107 drivers/net/wireless/iwlwifi/pcie/drv.c       Emmanuel Grumbach      2015-06-11  1297  	mutex_unlock(&trans_pcie->mutex);
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1298  
5fdda0476c28ff drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg          2013-08-02  1299  	return 0;
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1300  }
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach      2011-05-24  1301  

:::::: The code at line 1236 was first introduced by commit
:::::: 093305d801fae6ff9b8bb531fd78b579794c4f80 wifi: iwlwifi: pcie: simplify the resume flow if fast resume is not used

:::::: TO: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
:::::: CC: Miri Korenblit <miriam.rachel.korenblit@intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
