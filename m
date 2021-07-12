Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402672
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 22:27:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="273896096"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="273896096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:27:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="502479458"
Received: from archidas-mobl1.amr.corp.intel.com ([10.212.129.5])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:27:11 -0700
Date: Mon, 12 Jul 2021 15:27:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: fix ADD_ADDR and
 RM_ADDR maybe flush addr_signal each other"
In-Reply-To: <CA+WQbwuTi7iqN-2=b0kehULSABvVJ_ayS-w+ahbBPQq8i7mGgg@mail.gmail.com>
Message-ID: <6ddf9ad-6ef-c1b-7d90-375ddc3e0e2@linux.intel.com>
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com> <5802c6e8aac9d3a6502fd3a8e9cdda01f658dbcf.1626016245.git.geliangtang@gmail.com> <11cc4e68-8daa-0148-15ef-6b3bbccabc96@chinatelecom.cn>
 <CA+WQbwuTi7iqN-2=b0kehULSABvVJ_ayS-w+ahbBPQq8i7mGgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-807780647-1626128540=:28067"
Content-ID: <8191de9d-9bbb-a379-b450-7fa3128b20a2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-807780647-1626128540=:28067
Content-Type: text/plain; CHARSET=ISO-2022-JP; format=flowed
Content-ID: <8e968052-7662-64ad-b38b-bd1308c73b2@linux.intel.com>

On Mon, 12 Jul 2021, Geliang Tang wrote:

> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年7月12日周一 下午5:55写道：
>>
>>
>>
>> On 2021/7/11 23:15, Geliang Tang wrote:
>>> Add READ_ONCE() for reading msk->pm.addr_signal.
>>>
>>> Use mptcp_pm_should_add_signal_echo instead of open coding.
>>>
>>> Use '&=' to clear flag.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>> ---
>>>  net/mptcp/pm.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index c9622696716e..be16da2dcb6b 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -257,6 +257,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>                             struct mptcp_addr_info *saddr, bool *echo, bool *port)
>>>  {
>>>       int ret = false;
>>> +     u8 add_addr;
>>>
>>>       spin_lock_bh(&msk->pm.lock);
>>>
>>> @@ -271,10 +272,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>               goto out_unlock;
>>>
>>>       *saddr = msk->pm.local;
>>> -     if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
>>> -             WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
>>> +     add_addr = READ_ONCE(msk->pm.addr_signal);

Like below, pm.lock is held here so READ_ONCE() isn't needed.

>>> +     if (mptcp_pm_should_add_signal_echo(msk))
>>> +             add_addr &= ~BIT(MPTCP_ADD_ADDR_ECHO);
>>>       else
>>> -             WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL));
>>> +             add_addr &= ~BIT(MPTCP_ADD_ADDR_SIGNAL);
>>> +     WRITE_ONCE(msk->pm.addr_signal, add_addr);
>>>       ret = true;
>>>
>>>  out_unlock:
>>> @@ -294,7 +297,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>       if (!mptcp_pm_should_rm_signal(msk))
>>>               goto out_unlock;
>>>
>>> -     rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
>>> +     rm_addr = READ_ONCE(msk->pm.addr_signal);
>>> +     rm_addr &= ~BIT(MPTCP_RM_ADDR_SIGNAL);
>>>       len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>>>       if (len < 0) {
>>>               WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>>>
>>
>> These chunk of code is under the pm.lock so It is no need to use READ_ONCE() as Paolo saied before.
>
> I'll drop this READ_ONCE() in v2.
>
>>
>> --
>> Li YongLong
>
>

--
Mat Martineau
Intel
--0-807780647-1626128540=:28067--
