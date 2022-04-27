Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167A36B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 00:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651018932; x=1682554932;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4x4C236HLNj5DahUSaHMpWgdxp9mdxXXF47eq3KMWVc=;
  b=hQri9Kos6iVbgWPkVRUYEUhLpBEWfqhx3jfOkS9vanqteTC6DfE97ECS
   CI1S7S2JDHIDeLbd5xiPrtPkbQV2uAr8OYB7113wQ0zJZ5qBL5Dup7BHr
   7La/0H4egUNz2E462H5cJmFS2p/2JKlRWtkqIZGBGhWBHg//z5HkF97PE
   g2rDj+zRV42WaJO9ciIxt7BRE5poAteQY9SREdgHH7zvItxB2wCKWVpo+
   mrd5N4iLELV2bf94aiu4oxf2MGSK0ldN76WgQW263nI/zTLia6K+lyMJT
   ts8daks4y1jHaff8gfEsw09PyoqCHsKpCqUEfX0TCHrMPZRN+OGIR+prf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264611159"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="264611159"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:22:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532931336"
Received: from brpivitt-mobl1.amr.corp.intel.com ([10.252.136.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:22:00 -0700
Date: Tue, 26 Apr 2022 17:22:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: test
 bpf_skc_to_mptcp_sock"
In-Reply-To: <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com>
Message-ID: <3011f415-f363-18cd-f01e-98398ef7814f@linux.intel.com>
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com> <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com> <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 26 Apr 2022, Mat Martineau wrote:

> On Tue, 26 Apr 2022, Geliang Tang wrote:
>
>> Add CONFIG_MPTCP check.
>> 
>> When CONFIG_MPTCP is not enabled, we'll get a clearer error message:
>> 
>> libbpf: extern CONFIG_MPTCP (strong) not resolved
>> libbpf: failed to load object './mptcp_sock.o'
>> 
>> The message before is like this:
>> 
>> libbpf: prog '_sockops': BPF program load failed: Invalid argument
>> libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --
>> 
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> tools/testing/selftests/bpf/progs/mptcp_sock.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>
> Looks like this also requires CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC, can 
> you also add those to tools/testing/selftests/bpf/config? Maybe that should 
> be a separate commit, since other bpf test progs appear to rely on this 
> undocumented config requirement.
>

I hit 'send' too soon... We should still squash this, and add that second 
commit for the config information.

- Mat

>
>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c 
>> b/tools/testing/selftests/bpf/progs/mptcp_sock.c
>> index 5cfaec4e7245..7b6a25e37de8 100644
>> --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
>> +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
>> @@ -7,6 +7,7 @@
>> 
>> char _license[] SEC("license") = "GPL";
>> __u32 _version SEC("version") = 1;
>> +extern bool CONFIG_MPTCP __kconfig;
>> 
>> struct mptcp_storage {
>> 	__u32 invoked;
>> @@ -46,6 +47,9 @@ int _sockops(struct bpf_sock_ops *ctx)
>> 		if (!storage)
>> 			return 1;
>> 	} else {
>> +		if (!CONFIG_MPTCP)
>> +			return 1;
>> +
>> 		msk = bpf_skc_to_mptcp_sock(sk);
>> 		if (!msk)
>> 			return 1;
>> -- 
>> 2.34.1
>> 
>> 
>> 
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel
