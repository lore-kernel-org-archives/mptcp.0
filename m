Content-Type: multipart/mixed; boundary="===============0949558421825321812=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] mptcp: refactor recvmsg()
Date: Wed, 18 Sep 2019 15:41:26 -0700
Message-ID: <alpine.OSX.2.21.1909181504180.40632@tvtrimel-mobl5.amr.corp.intel.com>
In-Reply-To: 8722cc5a3e24820317a0e39bc02be900482fe347.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1881

--===============0949558421825321812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 18 Sep 2019, Paolo Abeni wrote:

> On Tue, 2019-09-17 at 16:05 -0700, Mat Martineau wrote:
>> @@ -658,60 +653,44 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
>>>
>>> 		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
>>> 			/* Mapping covers data later in the subflow stream,
>>> -			 * discard unmapped data.
>>> +			 * currently unsupported.
>>> 			 */
>>> -			pr_debug("Mapping covers data later in stream");
>>> -			discard_len =3D subflow->map_subflow_seq - ssn;
>>> +			WARN_ONCE(1, "Mapping covers data later in stream");
>>> +			copied =3D -EBADFD;
>>> +			break;
>>> 		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
>>> 						  subflow->map_data_len)))) {
>>> 			/* Mapping ends earlier in the subflow stream.
>>> -			 * Invalidate the mapping and try again.
>>> +			 * Invalid
>>> 			 */
>>> -			subflow->map_valid =3D 0;
>>> -			pr_debug("Invalid mapping ssn=3D%d map_seq=3D%d map_data_len=3D%d",
>>> -				 ssn, subflow->map_subflow_seq,
>>> -				 subflow->map_data_len);
>>> -			continue;
>>> -		} else {
>>> -			ack_seq =3D get_mapped_dsn(subflow);
>>> -
>>> -			if (before64(ack_seq, old_ack)) {
>>> -				/* Mapping covers data already received,
>>> -				 * discard data in the current mapping
>>> -				 * and invalidate the map
>>> -				 */
>>> -				u64 map_end_dsn =3D subflow->map_seq +
>>> -					subflow->map_data_len;
>>> -				discard_len =3D min(map_end_dsn - ack_seq,
>>> -						  old_ack - ack_seq);
>>> -				subflow->map_valid =3D 0;
>>> -				pr_debug("Duplicate MPTCP data found");
>>> -			}
>>> +			WARN_ONCE(1, "Mapping covers old data ssn=3D%d "
>>> +				  "map_seq=3D%d map_data_len=3D%d", ssn,
>>
>> Checkpatch will complain about concatenating string constants like this -
>> it allows long lines when string constants are involved.
>
> Thank you for the review.
>
> I was unable to compress the message in a single line fitting 80 chars,
> so I opted for splitting it (checkpatch would complain anyway)

That's the obscure detail I was trying to get at: checkpatch does not =

complain about lines over 80 chars when the length is due to a long string =

constant. It is ok to have long lines in that case, so there's no need to =

compress the messages.

>
> I'll mangle the messages and re-submit (fixing the typo in 2/2, too)

Thanks for the fixes!

--
Mat Martineau
Intel

--===============0949558421825321812==--
