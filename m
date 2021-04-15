Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1C6D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 15:35:51 +0000 (UTC)
IronPort-SDR: VLzaTK13dg+Ms3E2C8jE1hHsaNCuzEObVKBgp2oAcy7keOGp423QvYI5fJiGCVqaxB1MZoRdK3
 V67kUINwst9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280190171"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="280190171"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 08:35:43 -0700
IronPort-SDR: MLZMoC5batTHQko0GGDE5SclEaYizymmairp0Zd7no/42g9m1U7oFYmgivUyqywNYNFKYdwrwt
 1vGNPdMLlxEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="601170476"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2021 08:35:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 08:35:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 08:35:41 -0700
Received: from fmsmsx611.amr.corp.intel.com ([10.18.126.91]) by
 fmsmsx611.amr.corp.intel.com ([10.18.126.91]) with mapi id 15.01.2106.013;
 Thu, 15 Apr 2021 08:35:41 -0700
From: "Othman, Ossama" <ossama.othman@intel.com>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Multipath TCP Daemon (mptcpd) 0.7 released
Thread-Topic: Multipath TCP Daemon (mptcpd) 0.7 released
Thread-Index: AdcyDPv8t9CLblM9Tum7N2HTmsrHng==
Date: Thu, 15 Apr 2021 15:35:40 +0000
Message-ID: <5d92066d64c447249e2010a6973e65a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

The mptcpd 0.7 release is now available on GitHub:

    https://github.com/intel/mptcpd/releases

Notable changes include the following:

- MPTCP path management generic netlink events recently added to the
  upstream Linux kernel are now supported, and propagated to mptcpd
  plugins.  The same API is also found in the multipath-tcp.org
  kernel.  Differences between the two kernels are transparent to
  mptcpd plugins.

- Mptcpd now supports the upstream Linux kernel server-oriented
  MPTCP_PM_CMD_SET_FLAGS generic netlink command through the new
  mptcpd_pm_set_flags() function.  It allows the user to set MPTCP
  flags for a specific local IP address.

- An incorrect buffer size calculation when calling
  mptcpd_pm_add_addr() when using an IPv6 addresses on platforms
  running the upstream Linux kernel was corrected.

- An "operation not supported" error that occurred when attempting to
  retrieve MPTCP resource limits through the mptcpd_pm_get_limits()
  function was fixed.

- A network interface lookup problem in the "sspi" plugin was
  corrected.

- Building mptcpd against ELL 0.39 is now supported.

