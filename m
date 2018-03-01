Content-Type: multipart/mixed; boundary="===============8431908118616523262=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Thu, 01 Mar 2018 11:37:09 -0800
Message-ID: <alpine.OSX.2.21.1803011132510.24753@mjmartin-mac01.local>
In-Reply-To: 20180301004439.GN2038@MacBook-Pro-4.local
X-Status: 
X-Keywords:                  
X-UID: 334

--===============8431908118616523262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2018, Christoph Paasch wrote:

> On 28/02/18 - 15:44:39, Mat Martineau wrote:
>> On Wed, 28 Feb 2018, Christoph Paasch wrote:
>>
>>> On 27/02/18 - 10:50:38, Mat Martineau wrote:
>>>>
>>>> Hi Christoph,
>>>>
>>>> On Mon, 26 Feb 2018, Christoph Paasch wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> as for next steps after the submission of the TCP-option framework to=
 netdev
>>>>> and DaveM's feedback on it.
>>>>>
>>>>> Even if the submission got rejected, I think we still have a very use=
ful set
>>>>> of patches here. The need for a framework might pop up again in the f=
uture,
>>>>> and so these patches could come in handy.
>>>>> Mat, maybe you can put our latest submission on your kernel.org-git r=
epo
>>>>> just so that we don't lose track of these patches?
>>>>
>>>> Done: https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.=
git/log/?h=3Dmd5
>>>
>>> Thanks!
>>>
>>>>> I can also create a github repo if you prefer that.
>>>>>
>>>>>
>>>>> As for DaveM's feedback, the main takeaway - as Mat already noted on =
his other
>>>>> mail - is that fast-path performance he the highest priority. Branchi=
ng and
>>>>> indirect function calls are hardly accepted there.
>>>>>
>>>>>
>>>>> So, in that spirit I think we need to work towards reducing MPTCP's
>>>>> intrusiveness to the TCP stack.
>>>>>
>>>>> * Stop taking meta-lock when receiving subflow data (all the changes =
where
>>>>>  we check for mptcp(tp) and then do bh_lock_sock(meta_sk)).
>>>>>  The reason we do this in today's implementation is because it allows=
 to
>>>>>  access the meta data-structure at any point. If we stop taking the
>>>>>  meta-lock a few things need to change:
>>>>>  1. Do lockless accesses for selected fields (e.g., for the DATA_ACK).
>>>>>  2. Group the more intrusive accesses to few select points in the TCP=
-stack
>>>>>     where we then take the meta-lock (e.g., when receiving data).
>>>>>     (this would be equivalent as if the TCP-option framework would be=
 there
>>>>>     - thus we need to move code to these or similar points in the sta=
ck)
>>>>>  3. Sometimes schedule work-queues when we need to avoid deadlocks du=
e to
>>>>>     lock-ordering issues (e.g., when we can't take the meta-lock beca=
use
>>>>>     it's already held by another thread).
>>>>>
>>>>>  I think, the way to approach this here, is by working iteratively an=
d start
>>>>>  moving code in such a way that accesses to the meta-socket are group=
ed
>>>>>  together.
>>>>>
>>>>>  Also, we have a few callbacks that we added (cfr., struct tcp_sock_o=
ps).
>>>>>  We added them to avoid duplicating the code. Let's review those and =
see if
>>>>>  we can get rid of them. (as an example: .send_fin could be removed a=
s it is only
>>>>>  called from tcp_shutdown, called from the .shutdown callback in tcp_=
prot -
>>>>>  thus if we expose a separate MPTCP socket-type with its own struct p=
roto,
>>>>>  we can get rid of the .send_fin callback)
>>>>>
>>>>
>>>> I think a separate MPTCP socket type will be important for upstream
>>>> acceptance. My team has been working on some code with this separate s=
ocket
>>>> type that we can share.
>>>
>>> Great! I would love to move MPTCP to a separate socket-type.
>>>
>>>> I'm thinking that it will be useful to share once a
>>>> connection can stay up without falling back to TCP.
>>>
>>> Hmm... I'm not sure I understand. What do you mean with "connection can=
 stay
>>> up without falling back to TCP".
>>
>> Sorry, to clarify:
>>
>> The code I have today does not process incoming DSS options or send a da=
ta
>> ack, so the connection falls back to regular TCP after a couple of packe=
ts.
>> It's based on net-next.
>
> Oh, so it is not integrated on top of the MPTCP-code and rather a fresh
> start from scratch?

Not entirely from scratch, but mostly.

>> I would like to get my code to a point where it sends a correct data ack=
 so
>> the connection does not fall back, and at that point post the code on
>> git.kernel.org and as a patch set on this list.
>
> Maybe, even if the data-reception is not yet working, I still would be
> intersted in the MPTCP socket-type patches. Because that could be integra=
ted
> into multipath-tcp.org.
>
> Because, getting the data-reception to work if you started from scratch is
> going to take you a lot of time.

We've been working on it for a while, and I'm pretty close to having data =

reception working (just a single subflow, no join, various other early =

implementation constraints).

>
>>>>> * Investigate how/if we can make MPTCP adopt KCM or ULP.
>>>>
>>>> My main concern about ULP is that only one upper layer protocol can be=
 set
>>>> up (at least as the code is now), so you wouldn't be able to do someth=
ing
>>>> like use in-kernel TLS over MPTCP. Other than that, it seems like a na=
tural
>>>> fit for MPTCP.
>>>
>>> Do you think it would be feasible to make ULP use multiple ULPs ?
>>
>> I think it's possible to have a layered approach to ULP, maybe by provid=
ing
>> a list of protocols to setsockopt. It would be nice to have some
>> infrastructure to help implement it correctly, rather than depending on =
each
>> ULP to correctly call in to the layer below it whether it's the "normal"=
 TCP
>> code or some other ULP. The combinatorics would be a headache for sure:
>> running TLS over an MPTCP connection makes sense, but MPTCP layered on t=
op
>> of TLS doesn't make sense. At least if all the protocols were specified =
in
>> one setsockopt we could limit which combinations are allowed.
>
> Yes, MPTCP in this case would be special as it is so tightly coupled to T=
CP.
>
> MPTCP is always the protocol that would be at the bottom of the stack I
> think.

Ok, thanks for the confirmation.


--
Mat Martineau
Intel OTC

--===============8431908118616523262==--
