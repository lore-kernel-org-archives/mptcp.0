Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136D3D93
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 21:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651096069; x=1682632069;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mgTxYwY7XUmRdqS8K5XEd2SBGMZ0Jq6/nqVj4/hDmkI=;
  b=VxKa5qOynOgBpKyem1w6D3F5/pHM+nhoGM/7+aqKk9K9hVBYpk/uYCtm
   MicVoYoTdRZU5N9Ii9coEuUrZJwg6d8uh+jn3UlmIZLe1EA+esgC3Itdr
   o5CeAZXa8hlnMKrhGYkbkh/LGAJuvlMOdupHdRV9cQq6XLBRly+lSdtOg
   00k3OfxP2qmp9S9JVtjyb4Wq9fUz9K7/Wa40uI1TOL/9oL5CDt7VcUhbk
   322UH20/8b4BvjILxEL1ZGgPB5r184XWBlaCpZYF/BM1d0bolS4MHMBBA
   QF9YfulftK85H0aCwE2KV0CuHvql5ZU0CZEEkZ7++dP5mEXD6+ypy29zJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="326571228"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="326571228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 14:47:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="513901089"
Received: from ddavid-mobl2.amr.corp.intel.com ([10.209.54.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 14:47:49 -0700
Date: Wed, 27 Apr 2022 14:47:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Geliang Tang <geliang.tang@suse.com>, 
    MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: test
 bpf_skc_to_mptcp_sock"
In-Reply-To: <CA+WQbwu2n-Wva1Ja2dFxkbsQtfitCgUrK_KMQfm2VJPCsBmxig@mail.gmail.com>
Message-ID: <db186e4e-491e-2384-ad51-f18e73faf0b0@linux.intel.com>
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com> <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com> <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com>
 <CA+WQbwu2n-Wva1Ja2dFxkbsQtfitCgUrK_KMQfm2VJPCsBmxig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1088677945-1651096069=:58836"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1088677945-1651096069=:58836
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 27 Apr 2022, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2022年4月27日周三 08:20写道：
>>
>> On Tue, 26 Apr 2022, Geliang Tang wrote:
>>
>>> Add CONFIG_MPTCP check.
>>>
>>> When CONFIG_MPTCP is not enabled, we'll get a clearer error message:
>>>
>>> libbpf: extern CONFIG_MPTCP (strong) not resolved
>>> libbpf: failed to load object './mptcp_sock.o'
>>>
>>> The message before is like this:
>>>
>>> libbpf: prog '_sockops': BPF program load failed: Invalid argument
>>> libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> tools/testing/selftests/bpf/progs/mptcp_sock.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>
>> Looks like this also requires CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC,
>> can you also add those to tools/testing/selftests/bpf/config? Maybe that
>> should be a separate commit, since other bpf test progs appear to rely on
>> this undocumented config requirement.
>
> In my test, this bpf base test still works without CONFIG_IKCONFIG and
> CONFIG_IKCONFIG_PROC:
>
>> ls /proc/config.gz
> ls: cannot access '/proc/config.gz': No such file or directory
>> sudo ./test_progs -n 103
> #103 mptcp:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>

Huh, I wonder what's going on? It fails for me:

$ sudo ./test_progs -v -a mptcp
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
libbpf: failed to open system Kconfig
libbpf: failed to load object './mptcp_sock.o'
run_test:FAIL:165
test_base:FAIL:227
libbpf: failed to open system Kconfig
libbpf: failed to load object './mptcp_sock.o'
run_test:FAIL:165
test_base:FAIL:244
#103/1 mptcp/base:FAIL
(cgroup_helpers.c:146: errno: Device or resource busy) Removing cgroup: /mnt/cgroup-test-work-dir831/mptcp
(cgroup_helpers.c:146: errno: Device or resource busy) Removing cgroup: /mnt/cgroup-test-work-dir831
#103 mptcp:FAIL

All error logs:
#103 mptcp:FAIL

Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

This is with Fedora 35. I'll check the BPF CI to see if there's any 
information about their configuration that might explain the difference.


- Mat

>
>
>>
>> - Mat
>>
>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
>>> index 5cfaec4e7245..7b6a25e37de8 100644
>>> --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
>>> @@ -7,6 +7,7 @@
>>>
>>> char _license[] SEC("license") = "GPL";
>>> __u32 _version SEC("version") = 1;
>>> +extern bool CONFIG_MPTCP __kconfig;
>>>
>>> struct mptcp_storage {
>>>       __u32 invoked;
>>> @@ -46,6 +47,9 @@ int _sockops(struct bpf_sock_ops *ctx)
>>>               if (!storage)
>>>                       return 1;
>>>       } else {
>>> +             if (!CONFIG_MPTCP)
>>> +                     return 1;
>>> +
>>>               msk = bpf_skc_to_mptcp_sock(sk);
>>>               if (!msk)
>>>                       return 1;
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>
>> --
>> Mat Martineau
>> Intel
>>
>

--
Mat Martineau
Intel
--0-1088677945-1651096069=:58836--
