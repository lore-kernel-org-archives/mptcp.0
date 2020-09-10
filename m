Content-Type: multipart/mixed; boundary="===============4758054729137221358=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Thu, 10 Sep 2020 18:43:03 +0200
Message-ID: <eaac35d1-30e7-7cea-27dd-35fe1a733af2@tessares.net>
In-Reply-To: abea8e84cac295979dd0a3b7d2662c192d2aa4f2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5788

--===============4758054729137221358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 09/09/2020 18:45, Paolo Abeni wrote:
> On Tue, 2020-09-08 at 13:33 -0700, Mat Martineau wrote:
>> On Mon, 7 Sep 2020, Paolo Abeni wrote:
>>> We already have 'schedule_work' call to handle incoming data fin
>>> in mptcp_incoming_options(), can we instead extend the checks there to
>>> cover also this scenario?
>>>
>>
>> I did look at modifying mptcp_incoming_options(), but this patch looked
>> like the simpler fix.
>>
>> The existing checks for empty packets in mptcp_incoming_options()
>> accomplish two things:
>>
>> 1. DATA_FIN is handled for ACK packets that don't get in to the subflow
>> receive queue (TCP FIN packets do go in to the receive queue, even if
>> there's no payload).
>>
>> 2. skb_ext attachment is skipped for ACK packets.
>>
>>
>> Changing the logic in mptcp_incoming_options() would have to look for
>> seq+1 =3D=3D end_seq and TCP FIN, and then (maybe?) not attach the skb_e=
xt -
>> which significantly changes the code paths involved. It might also do an
>> extra wake up of the worker before the MPTCP socket is caught up with the
>> incoming data.
>>
>> In comparison, the above patch stores a return value that was previously
>> (incorrectly) ignored, and schedules the worker when it is most likely to
>> be able to do the work.
>>
>> Given that, do you think it's better to extend the
>> mptcp_incoming_options() checks?
> =

> Yup, I did not look into the details of the other option. It looks like
> it's overcomplicated, so I'm ok with this approach.

Thank you for the patch and the review!

I just applied your patch with Paolo's ACK!

Compilation tests are OK, "export" branch has been updated but the CI is =

still validating functional tests in the VM (selftests, packetdrill, etc.).

I will try to report the status later on IRC but if you don't hear from =

me today, I am sure this patch can be sent to netdev!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4758054729137221358==--
