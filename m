Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32780362
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664237455; x=1695773455;
  h=date:from:to:subject:message-id:mime-version;
  bh=GyWq7LPGxcyXUdJ5XtACdjNTZyNruNTJyWHKUyj2cLM=;
  b=EyoASy2BiFyZ0ToPVgmuzgzdKmPtmiYtDvIuCcVDx3Ii10X843vqCi09
   S+z7dPjhaQgeFM/dL0WuQOa7Sn5vv/1pHa7+pV+ll+o4l/+OYvBVdcFsG
   U6gGgpPN+vQwrDMK/ix7b0XCSrf+MxwvMrxPIE792jVUTDbqMyJC3oCtr
   kTflEbKcMxxBpJmy1eEkxk4MH8HVKVDEL8GKCxbtPuDv3doJSeWFny458
   S/0OUO+3+lrmpHow5OAHN1kC3IAqSBJqqrfQEkRn1FMXkQTjm1r6XVHzV
   dT8n8v3Z6gO5xEAonRlHQKxzht3aKJkl0OEZ4Rlqq7T5tL5kVlpT58cJ9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288317912"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="288317912"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 17:10:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="725281367"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="725281367"
Received: from msakmal-mobl.amr.corp.intel.com ([10.209.99.219])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 17:10:54 -0700
Date: Mon, 26 Sep 2022 17:10:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: MPTCP upstreaming, week of 26-Sept-2022
Message-ID: <57e168ae-9de0-c986-cab1-a130e72e4e95@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1085618361-1664237454=:4723"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1085618361-1664237454=:4723
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Matthieu and Paolo -

I upstreamed the fastopen changes for net-next today, so those are in the 
patchwork queue for the netdev maintainers:

https://patchwork.kernel.org/project/netdevbpf/list/?series=680767


The other patch sets we discussed upstreaming in the meeting last week 
were:

     - Fixes for -net:

         - [6e827151a607] mptcp: factor out __mptcp_close() without socket lock (Menglong Dong)
         - [62b5536f77f6] mptcp: fix unreleased socket in accept queue (Menglong Dong):
             - can wait a bit more and can be sent next week


     - Features for net-next:

         - [ef4a93571133] mptcp: propagate fastclose error (Paolo Abeni)
         - [885cab8b5203] mptcp: use fastclose on more edge scenarios (Paolo Abeni)
         - [13c82c8b0d9f] selftests: mptcp: update and extend fastclose test-cases (Paolo Abeni):
             - can wait a bit, Paolo would like to have a look at the modification on packetdrill side


I'm planning to upstream the two -net patches on Tuesday unless someone 
objects.


The net-next patches are slightly more complicated:

  * They were updated with a squash-to patch today
  * Need to wait until fastopen patches are merged
  * There is a minor conflict with the -net patches (just diff context)
    in "mptcp: use fastclose on more edge scenarios".


Regarding the conflict, I could wait until Friday for a likely 
net/net-next sync.

Another option is to modify the patch slightly by moving 
mptcp_check_readable() before __mptcp_check_send_data_fin(), it doesn't 
make the diff any larger and avoids the -net conflict. What do you think?

--
Mat Martineau
Intel
--0-1085618361-1664237454=:4723--
