Content-Type: multipart/mixed; boundary="===============6154677960943925533=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 4/4] mptcp: allow collapsing consecutive
 sendpages on the same substream
Date: Wed, 10 Apr 2019 10:16:25 -0700
Message-ID: <alpine.OSX.2.21.1904100926070.26395@ztahiru-mobl1.amr.corp.intel.com>
In-Reply-To: 91da8a97d57aeca139f08b7495bd56fe563d0b05.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1060

--===============6154677960943925533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 10 Apr 2019, Paolo Abeni wrote:

> On Fri, 2019-04-05 at 17:34 -0700, Mat Martineau wrote:
>> On Fri, 5 Apr 2019, Paolo Abeni wrote:
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 2fbfe3e30630..5df2283de488 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -47,11 +47,19 @@ static struct sock *mptcp_subflow_get_ref(const str=
uct mptcp_sock *msk)
>>> 	return NULL;
>>> }
>>>
>>> +static inline bool mptcp_skb_can_collapse_to(const struct mptcp_sock *=
msk,
>>> +					     const struct sock *ssk,
>>> +					     const struct sk_buff *skb)
>>> +{
>>> +	return tcp_skb_can_collapse_to(skb) && (msk->last =3D=3D ssk);
>>
>> Even if the last send was on a particular subflow, that doesn't guarantee
>> the next send can be collapsed on that subflow. There are other cases li=
ke
>> MPTCP-level resends or sending duplicate data on different subflows.
>
> uhmm... I thought a bit more about the above and the code in the patch
> still LGTM: msk->last references the last subflow we enqueued new data
> to, that is, the subflow with the higher/newer MPTCP write_seq...
>
>> I think it would have to make sure the MPTCP-level sequence numbers are
>> contiguous before collapsing.
>
> ... so this condition always held, when (msk->last =3D=3D ssk).
>
> Am I missing something?
>

Resends will be a problem with the "last subflow written to" assumption.

In a case where you have multiple subflows S1 and S2, you might have a =

scenario like this (sequence numbers are in the 64-bit MPTCP sequence =

space):

1. Send bytes 0-99 on S1

2. Send bytes 100-199 on S2

3. <time passes: S2 connection has a problem and data does not get =

through>

4. Send bytes 200-299 on S1

5. MPTCP-level resend 100-199 on S1

6. Send bytes 300-399 on S1


When you get to step 6, the "last" send was on S1, but you need a new =

MPTCP mapping header for bytes 300-399 because the previous byte in the S1 =

stream is 199. It's important to know where the earlier mappings end so =

you can create a new one without leaving a gap in the MPTCP sequence =

space.



--
Mat Martineau
Intel

--===============6154677960943925533==--
