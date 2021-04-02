Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C75F
	for <mptcp@lists.linux.dev>; Fri,  2 Apr 2021 18:16:22 +0000 (UTC)
IronPort-SDR: zdlBnmcNlkvFDU9wAxlcmC8oe64WzsNeIl2+bb+tjx7VasaBH3e9JDXN8ovyfXZT74dM1RnloB
 JEDbN8g59zWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="256493450"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="256493450"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:16:22 -0700
IronPort-SDR: QjfyoyCCDA8MPFhw2Nr9KeTTa76R+cndE5E61slFOEA87Ouo1/MHGl5GCQ7Qo3w3gZPzWGmdyb
 W3HAukbp9oyg==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="611384934"
Received: from kingchax-mobl2.amr.corp.intel.com ([10.254.67.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:16:19 -0700
Date: Fri, 2 Apr 2021 11:16:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 1st of April 2021
In-Reply-To: <c82ad526-4572-8a5a-5f42-e27cf70e8e25@tessares.net>
Message-ID: <e82a1171-8652-cb4b-15ec-8fe8e0b5cb20@linux.intel.com>
References: <c82ad526-4572-8a5a-5f42-e27cf70e8e25@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1588474382-1617387379=:88863"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1588474382-1617387379=:88863
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Thu, 1 Apr 2021, Matthieu Baerts wrote:

>    - news about Intel's kbuild? (Mat):
>        - start sending build results again
>        - some issues with mptcp_join.sh but no details for unknown reason
>        - Matth got an issue with "36 add multiple addresses IPv6 → got 1 
> ADD_ADDR echo[s] expected 2"
>

I got the log question sorted out. The mptcp_join.sh failures on kbuild 
were for these export branch heads:

ad3c71fdd3ee7540e8ba1b9d7f0065c97e8a1eb7
6d4168bb28cdda95a2a8462fbc825af273523909

Both were 600 second timeouts, with this message printed every 10 
seconds:

kern  :emerg : [   79.224292] unregister_netdevice: waiting for ip6gre0 to become free. Usage count = 2

The pm_netlink.sh tests had completed successfully right before attempting 
mptcp_join.sh.



--
Mat Martineau
Intel
--0-1588474382-1617387379=:88863--
