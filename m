Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA332FB8
	for <mptcp@lists.linux.dev>; Sat, 12 Jun 2021 03:57:13 +0000 (UTC)
IronPort-SDR: k+MpAJaRYR7uTN75x3FPp38Mt+x4dOyUzoC6GUrGmMofmHLGIN6iF3gDOWBTWYVFsVnKIag1JB
 DbgVEkvbICaw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291274789"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="291274789"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 20:57:12 -0700
IronPort-SDR: hgEBB83yw38mUyRcHOu57uYAM4VYdv1+Wh2TA85fsE1FIzBBn/q06dRcpX0BfLkJ6VuXOzvbyT
 pxUq4ahEH4bA==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="620566378"
Received: from yseah-mobl.gar.corp.intel.com ([10.212.136.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 20:57:12 -0700
Date: Fri, 11 Jun 2021 20:57:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: MPTCP checksum interop
Message-ID: <aedffae2-61ad-eb44-c083-e674f736fd96@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


I did some tests with connections with checksums enabled, between the 
export branch and the multipath-tcp.org mptcp_trunk branch (v1 mode).

When the multipath-tcp.org kernel was listening, the connection would 
always fall back to TCP when the first data was sent by the upstream 
kernel. The multipath-tcp.org kernel was the first to fall back and stop 
sending MPTCP headers.

When the upstream kernel was listening, the multipath-tcp.org kernel would 
send corrupt TCP options with the first data packet (the first time a DSS 
option was sent). The upstream kernel would then send TCP RST.

The initial impression is that there are some issues with mptcp_trunk and 
checksums - I did not have time today to look at packet captures between 
two mptcp_trunk kernels.

These results were the same when only one side of the connection had 
checksums enabled, or if both kernels did.

I haven't narrowed down the cause, but will do some more experiments on 
Monday.

--
Mat Martineau
Intel
