Content-Type: multipart/mixed; boundary="===============3193832571434690271=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Remove all traces of checksum support
Date: Tue, 17 Sep 2019 14:35:55 -0700
Message-ID: <alpine.OSX.2.21.1909171423330.32589@mjmartin-mac01.local>
In-Reply-To: 97cca90e428829e7e415b8a2cb76eb4e639469c1.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1871

--===============3193832571434690271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 17 Sep 2019, Peter Krystad wrote:

> On Tue, 2019-09-17 at 11:24 +0200, Paolo Abeni wrote:
>> Hi,
>>
>> On Mon, 2019-09-16 at 15:10 -0700, Peter Krystad wrote:
>>> @@ -152,10 +151,27 @@ void mptcp_parse_option(const unsigned char *ptr,=
 int opsize,
>>>  				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK64;
>>>  			else
>>>  				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK32;
>>> +		}
>>> +
>>> +		if (mp_opt->use_map) {
>>> +			if (mp_opt->dsn64)
>>> +				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
>>> +			else
>>> +				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP32;
>>> +		}
>>>
>>> -			if (opsize < expected_opsize)
>>> -				break;
>>> +		/* RFC 6824, Section 3.3:
>>> +		 * If a checksum is present, but its use had
>>> +		 * not been negotiated in the MP_CAPABLE handshake,
>>> +		 * the checksum field MUST be ignored.
>>> +		 */
>>> +		if (opsize !=3D expected_opsize &&
>>> +		    opsize !=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
>>> +			break;
>>
>> My understanding is that we should look for RFC 6824 bis compliance -
>> is that correct?
>
> That's the feedback we got.
>
>> If so, than we should reset the subflow connection if opsize =3D=3D
>> expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM, and just ignore other bad
>> len. Is that correct? (looks a bit weird to me)
>>
> And that's my reading of the 6824bis too. But the code base is v0 right n=
ow,
> so I think this is OK going in like this, the purpose of this patch is ju=
st to
> make it clear we don't support checksum. Maybe add a comment here that it=
 will
> need revision for v1? I think it will make sense to move to v1 in one (or
> more) coordinated patchsets instead of trickling support in over time.

I agree that we should switch from v0 to v1 all at once - preferably when =

we have something to test against! I think we would benefit from =

interoperating with the v0.95 (protocol v0) kernel with the =

multiple-subflow transmission and reassembly changes and DATA_FIN before =

jumping in to v1 compliance.


Mat


>
>> I'm unsure we can reset the stream from mptcp_parse_option() even
>> providing it the relevant sock variable (and that would be a quite
>> invasive change).
>>
>> Perhaps we can mark the pkts/DSS/MPTCP ext as 'bad' using an additional
>> flag and send the reset later? (even at rcvmsg time)
>
> It is going to have to be something like that, but out-of-scope for this
> patch.
>
> Peter.
>
>
>>> @@ -701,18 +691,11 @@ void mptcp_write_options(__be32 *ptr, struct mptc=
p_out_options *opts)
>>>  		}
>>>
>>>  		if (mpext->use_map) {
>>> -			__sum16 checksum;
>>> -
>>> -			pr_debug("Writing map values");
>>>  			put_unaligned_be64(mpext->data_seq, ptr);
>>>  			ptr +=3D 2;
>>> -			*ptr++ =3D htonl(mpext->subflow_seq);
>>> -
>>> -			if (mpext->use_checksum)
>>> -				checksum =3D mpext->checksum;
>>> -			else
>>> -				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
>>> -			*ptr =3D htonl(mpext->data_len << 16 | checksum);
>>> +			put_unaligned_be32(mpext->subflow_seq, ptr);
>>> +			ptr +=3D 1;
>>> +			put_unaligned_be16(mpext->data_len, ptr);
>>
>> I think we should still set 4 bytes here:
>>
>> 	put_unaligned_be32(mpext->subflow_seq << 16 | TCPOPT_NOP << 8 |
>> TCPOPT_NOP, ptr);
>>
>> or we can hit some 'uninit value used' error triggered by syzbot or the
>> like.
>>
>> Cheers,
>>
>> Paolo
>>
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============3193832571434690271==--
