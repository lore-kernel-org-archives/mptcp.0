Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D76444
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 23:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647645570; x=1679181570;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fXqY0dnxH3g+uOn936rRx4bp3Xy3Az6/oxMx37UNQpM=;
  b=eOGijZcBMahgmxJI0xKlY4WIhTBvXu7glrffw5rY6HvOeJIx0tTR8Q+N
   NCSON0JLOI5VwQNlYTY7iKjk27RV6iN7DaHVd98PWd1OcEqyfMrSYmUZq
   jeIbUgkRSt6/GiJLVaovHx8C8Ys6w0x7cTHtwMTqLw/wliZ3kIN10AN1O
   VYYER9UiWDitSa0bilnw3B1Fwa6vPZ0H4doUNRviIXqjdQ0QT3JpbpEsK
   xBcf48wLsXBO44twxfjPQihre0wwL//lfNmSfZKpdIiiP/fmey8+QnCO+
   3O1FxAgC297uhlImneVBlorkHFip5A5aXo5GcuDAc9U85XKzNwt5TISMm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256970620"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256970620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 16:19:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="614544189"
Received: from iitotia-mobl1.amr.corp.intel.com ([10.209.55.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 16:19:29 -0700
Date: Fri, 18 Mar 2022 16:19:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 0/6] MP_FAIL echo and retrans
In-Reply-To: <2775913c-722b-65b9-13f4-cfdcd5217e36@linux.intel.com>
Message-ID: <bfe8bd4-abf-5637-e2d8-a025313bd380@linux.intel.com>
References: <cover.1647327162.git.geliang.tang@suse.com> <2775913c-722b-65b9-13f4-cfdcd5217e36@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Mar 2022, Mat Martineau wrote:

> On Tue, 15 Mar 2022, Geliang Tang wrote:
>
>> v5:
>> - re-check for TCP_CLOSE.
>> - add a new helper mptcp_check_mp_fail_response().
>> - add two timers cleanup patches.
>> 
>
> Hi Geliang -
>
> v5 is looking good to me so far, but I still need to run some tests.
>

Ok, I got a chance to look at the packet traces from the self tests. I 
also tested with a shorter timeout and commented out the echo, and the 
subflow was reset as expected.

Looks good for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


It would be good to have a packetdrill test for this, even if it does take 
a couple of minutes to fail. We wouldn't have to run it in the normal CI.


Mat


>
>> v4:
>> - start and stop sk_timer instead of setting and clearing msk->flags.
>> - add a new patch.
>> 
>> v3:
>> - use msk->sk_timer and a msk->flags bit.
>> - use READ_ONCE/WRITE_ONCE for subflow->mp_fail_response_expect.
>> - update selftest.
>> 
>> v2:
>> - don't clear mp_fail_response_expect flag.
>> - add a helper mp_fail_response_expect_subflow to get the subflow,
>>   instead of using msk->first.
>> - add locks as Mat suggested.
>> - add a selftest.
>> 
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261
>> 
>> Geliang Tang (6):
>>  mptcp: use mptcp_stop_timer
>>  mptcp: add data lock for sk timers
>>  mptcp: add MP_FAIL response support
>>  mptcp: reset subflow when MP_FAIL doesn't respond
>>  selftests: mptcp: check MP_FAIL response mibs
>>  selftests: mptcp: print extra msg in chk_csum_nr
>> 
>> net/mptcp/pm.c                                | 18 +++++-
>> net/mptcp/protocol.c                          | 64 ++++++++++++++++++-
>> net/mptcp/protocol.h                          |  2 +
>> net/mptcp/subflow.c                           | 13 ++++
>> .../testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++++--
>> 5 files changed, 139 insertions(+), 7 deletions(-)
>> 
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
