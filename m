Content-Type: multipart/mixed; boundary="===============7483520228881510670=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/6] mptcp: separate accouting for wmem forward
 alloc mem
Date: Tue, 17 Nov 2020 13:07:16 -0800
Message-ID: <66b2f6a8-315-e498-94c1-229e6164c6cd@linux.intel.com>
In-Reply-To: 009f798fb0154c19bc4423a1271fecac14836282.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6764

--===============7483520228881510670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2020, Paolo Abeni wrote:

> On Tue, 2020-11-17 at 11:47 +0100, Florian Westphal wrote:
>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>> As mentioned before, one possible follow-up to this series is open-code
>>> a MPTCP-specific variant of lock_sock()/release_sock() which will allow
>>> performing some additional/MPTCP specific actions under the msk level
>>> spinlock.
>>>
>>> Specifically:
>>>
>>> - in recevmsg(), in lock_sock(), splice sk->sk_receive_queue in msk-
>>>> receive_queue
>>> - still in recvmsg(), in release_sock(), update the bulk freed rmem
>>>
>>> Overall this 2 will allow acquiring no additional spinlock at all in
>>> the average case for recvmsg()
>>>
>>> - in sendmsg(), in lock_sock(), move as much memory as needed from
>>> sk_forward_memory to wforward_memory, eventually allocating it.
>>> - in sendmsg(), in release_sock(), move again the unused
>>> wforward_memory to sk_forward_memory.
>>>
>>> Overall this 2 will allow acquiring no additional spinlock at all in
>>> the average case for sendmsg() and will avoid artifacts due to the
>>> sk_forward_memory/wforward_memory separation.
>>>
>>> But they additionally will allow replacing the wforward_memory field
>>> with a local variable.
>>>
>>> So I'm wondering if I should already code the above, to avoid
>>> introducing this additional new msk field just to remove it in a few
>>> patches !?!
>>
>> Tricky.
>
> The trickest part is probably getting a corret estimate for the wmem we
> are going to use. But we don't really need to be very accurate.
>
>> Do you have hunch of how much additional code churn that
>> means?
>>
>> If its not too much 'rewrite', I would prefer to do it later on
>> even if that means axing the newly added field.
>>
>> If it means to rewrite most of this again then its probably
>> better to do it right away.
>
> eh... the only way I had for a reasonable answer to the above was...
> trying to code it, do I did it ;)
>
> In the end I had to retain the newly added field - with a slightly
> different semantic and name:
>
> https://github.com/pabeni/mptcp/tree/worker_must_die_6
>
> I think overall it cleans things more than a bit...
>

Yes, I find the version of this patch in
https://github.com/pabeni/mptcp/tree/worker_must_die_6.1 to be cleaner =

than the version posted here without mptcp_lock_sock().

Did you intend to use __sk in the body of the mptcp_lock_sock() macro?


Thanks,

--
Mat Martineau
Intel
--===============7483520228881510670==--
