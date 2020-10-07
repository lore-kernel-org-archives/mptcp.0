Content-Type: multipart/mixed; boundary="===============5761147205721308371=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/2] mptcp: cope better with tcp_sendpage
 allocation
Date: Wed, 07 Oct 2020 15:20:37 -0700
Message-ID: <alpine.OSX.2.23.453.2010071514560.37718@ytakamor-mobl2.gar.corp.intel.com>
In-Reply-To: 7e9caf9b90d518037094b7e536e932e754e25895.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6244

--===============5761147205721308371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Oct 2020, Paolo Abeni wrote:

> On Tue, 2020-10-06 at 10:16 -0700, Mat Martineau wrote:
>> On Tue, 6 Oct 2020, Paolo Abeni wrote:
>>
>>> The current export branch suffers of the following issue:
>>>
>>> https://github.com/multipath-tcp/mptcp_net-next/issues/97
>>>
>>> To fix the above, MPTCP needs to be able to cope with memory allocation
>>> failure in do_tcp_sendpages().
>>>
>>> In this attempt, the relevant code is factored out of do_tcp_sendpages(=
),
>>> in a smaller helper, so that mptcp_sendmsg_frag() can avoid touching
>>> ssk->sk_socket.
>>>
>>> There are other possible alternatives:
>>> - add an explicit check in do_tcp_sendpages() for NULL sk->sk_socket
>>>  pro: very simple and little invasive
>>>  cons: hackysh?!?
>>> - inline/open-code the relevant part of do_tcp_sendpages in mptcp_sendm=
sg_frag()
>>>  pro: no need to change core TCP code
>>>  cons: code duplication, need to change the scope for a couple of TCP i=
nternal
>>>        helpers (removing the 'static' keyword)
>>>
>>> As a follow-up I would try to pre-allocate skbs and extensions, so that
>>> push_pending could be called in BH context and we could avoid using the
>>> work queue.
>>>
>>> I'm looking for feedback on the less ugly/more upstreamable approach
>>
>> I wouldn't object to the explicit sk->sk_socket check, it is simpler and
>> handling that in the existing do_error path in do_tcp_sendpages() does
>> make sense. It is, after all, an error that can be detected and handled.
>>
>> I think factoring out do_tcp_sendfrag() is "nice" enough - while it seems
>> like such a change might be preferred earlier in the net-next development
>> cycle it doesn't seem too invasive. The drawback I see is that there are
>> not likely to be other users of do_tcp_sendfrag().
>
> Thank you for the review and feedback!
>
> I would avoid adding mptcp-specific test in the TCP code, if possible,
> so my proposal is as follow:
>
> I'll rebase the patches to land on the "bottom" of the export branch -
> that is, just on top of the net-next branch, so that we could send them
> upstream ASAP - still on the next wnd, likely. Perhpas I can send them
> as RFC upstream while net-next will be closed.
>
> I'm wondering about changing do_tcp_sendfrag() signature to:
>
> struct sk_buff *
> do_tcp_sendfrag(struct sock *sk, int size_goal, int flags,
> 		struct page *page, int offset, int *size);
>
> that is, first socket related fields, than buffer related fields. It
> will return the used skb, so that the caller will not need the
> additional tcp_write_queue_tail(), and will use the 'size' argument as
> an in-out one. On return will contains the copied bytes value - this
> later change to avoid increasing the number of arguments for this
> function.
>
> Overall it should produce smaller code in both the TCP and MPTCP
> protocol, WDYT?

That has some similarities with what I wanted to do in the early drafts of =

the sendmsg code, but I was being very (overly?) paranoid about not =

touching TCP code. A good proposal in my opinion!

--
Mat Martineau
Intel
--===============5761147205721308371==--
