Content-Type: multipart/mixed; boundary="===============5529956064451260650=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] How function pointers will be replaced
Date: Thu, 29 Mar 2018 16:29:06 -0700
Message-ID: <c32831ff-c29f-3858-60a8-32aada29c982@oracle.com>
In-Reply-To: alpine.OSX.2.21.1803291304310.39118@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 476

--===============5529956064451260650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/29/2018 02:44 PM, Mat Martineau wrote:
>
> On Tue, 27 Mar 2018, Rao Shoaib wrote:
>
>> I am in the process of replacing function pointers with a macro that =

>> calls the appropriate function based on the socket. Mat, suggested =

>> that I share what it looks like. So here it is.
>>
>> The current code in the patch:
>>
>> /* Send _single_ skb sitting at the send head. This function requires
>> =C2=A0* true push pending frames to setup probe timer etc.
>> =C2=A0*/
>> void tcp_push_one(struct sock *sk, unsigned int mss_now)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D tcp_s=
end_head(sk);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!skb || skb->len < mss=
_now);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_sk(sk)->op_ops->write_xmi=
t(sk, mss_now, TCP_NAGLE_PUSH, 1,
>> sk->sk_allocation);
>> }
>>
>> After my fix to not use function pointers it will look like
>>
>> /* Send _single_ skb sitting at the send head. This function requires
>> =C2=A0* true push pending frames to setup probe timer etc.
>> =C2=A0*/
>> void tcp_push_one(struct sock *sk, unsigned int mss_now)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D tcp_s=
end_head(sk);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!skb || skb->len < mss=
_now);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CALL_ONE(tcp_write_xmit, sk, =
mss_now, TCP_NAGLE_PUSH, 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sk->sk_allocation);
>> }
>>
>> /* Macro to call appropriate function depending upon the socket type.
>> =C2=A0* First two arguments are required to be the name of the function =

>> called and socket
>> =C2=A0* pointer respectively. Any other arguments are optional as requir=
ed by
>> =C2=A0* the called function.
>> =C2=A0*/
>> #define CALL_ONE(fn, __sk, ...) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (likely (!tcp_sk(__sk)->tcp_a=
lt) ? \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (fn)(__sk, ##__VA_ARGS__) : (=
mp##fn)(__sk, ##__VA_ARGS__))
>>
>> I am not happy about this as function pointers kept the code cleaner. =

>> If anyone has better ideas or see any issues please speak up so I can =

>> make the change now than later.
>
> Yeah, I agree that function pointers are a simpler way to express the =

> intended behavior. It seems like davem wants conditional calls, and =

> this macro approach clearly implements that.
>
> Based on code idioms I've observed in the Linux kernel, my suggestion =

> is to not abstract the conditional call behind the macro and to use an =

> if statement at each call site so it's clear that control flow is =

> going to either the regular tcp call or the mptcp call without having =

> to look up the macro. I can't point to any written policy that says =

> this, but it would fit the existing code style better (in my opinion).
I can make that change, consider it as part of code review comment.
>
> If you'd like to stick with the macro, are CALL_ONE and tcp_alt =

> placeholders to illustrate the concept? Since the macro is =

> MPTCP-specific, I think it would help to have less generic names that =

> make the association with MPTCP clear.
At one point I was thinking of making this mechanism generic so that =

anyone would be able to substitute the functions by simply changing the =

prefix used in the macro and hence the name. I am open to whatever we =

need to call it.
>
> Yes, these are style comments. I point these things out because =

> maintainers do pay attention to this stuff for readability and =

> maintainability purposes. Like I said above, the macro works as =

> advertised, so the functionality is not in question.
I am very flexible as long as forward progress continues. The push back =

you saw was because I do not want to address=C2=A0 style comments just to g=
et =

a proposal reviewed. I am lazy and do not want to do that work if the =

patch has issues.

Thanks,

Shoaib


--===============5529956064451260650==--
