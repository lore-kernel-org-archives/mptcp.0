Content-Type: multipart/mixed; boundary="===============7200536436417154825=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: DSS map overrun in recvmsg()
Date: Wed, 15 May 2019 14:06:49 +0200
Message-ID: <8a384283-b4ef-9fbe-cfb6-edc642864fc5@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905141743570.17351@jdicke-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1175

--===============7200536436417154825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

Thank you for the patch and the review!

On 15/05/2019 02:47, Mat Martineau wrote:
> =

> On Tue, 14 May 2019, Paolo Abeni wrote:
> =

>> The code used to compute the remaning bytes in the current DSS
>> mapping in recvmsg() looks wrong.
>>
>> Since we compute map_offset in two different places, factor out
>> an helper for that tasks and use it.
> =

> Thanks for catching this Paolo. Your new map_remaining math is the
> correct calculation. I also tested against the multipath-tcp.org kernel
> (v0.94 branch) and that worked fine.
> =

> =

> Mat
> =

> =

>>
>> Fixes: 8dbe2f4c7f21 ("mptcp: Implement MPTCP receive path")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> notes:
>> - This fixes some of the self-tests failures, but other issues are
>> still there. Sending this early, as progress here looks slow and
>> hard, and a complete solution could be not so near
>> - This can be squashed into the 'fixes' commit

Just did:

- squash: 42101fe4c4998a79a918bd015319ce123e244076
- signed-off was already there

Cheers,
Matt

>> ---
>> net/mptcp/protocol.c | 14 ++++++++------
>> 1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 1c9b1e183d12..65f1df196657 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -230,13 +230,16 @@ static u64 expand_seq(u64 old_seq, u16
>> old_data_len, u64 seq)
>> =C2=A0=C2=A0=C2=A0=C2=A0return seq | ((old_seq + old_data_len + 1) & GEN=
MASK_ULL(63,32));
>> }
>>
>> -static u64 get_mapped_dsn(struct subflow_context *subflow)
>> +static u64 get_map_offset(struct subflow_context *subflow)
>> {
>> -=C2=A0=C2=A0=C2=A0 u32 map_offset =3D (tcp_sk(sock_sk(subflow))->copied=
_seq -
>> +=C2=A0=C2=A0=C2=A0 return tcp_sk(sock_sk(subflow))->copied_seq -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 subflow->ssn_offset -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 subflow->map_subflow_seq);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 subflow->map_subflow_seq;
>> +}
>>
>> -=C2=A0=C2=A0=C2=A0 return subflow->map_seq + map_offset;
>> +static u64 get_mapped_dsn(struct subflow_context *subflow)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return subflow->map_seq + get_map_offset(subflow);
>> }
>>
>> static int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
>> @@ -481,8 +484,7 @@ static int mptcp_recvmsg(struct sock *sk, struct
>> msghdr *msg, size_t len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Read mapped data */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map_remaining =3D (ssn - sub=
flow->map_subflow_seq +
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 subflow->map_data_len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map_remaining =3D subflow->m=
ap_data_len - get_map_offset(subflow);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc.count =3D min_t(size_t, =
len - copied, map_remaining);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg.msg =3D msg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes_read =3D tcp_read_sock(=
ssk, &desc, mptcp_read_actor);
>> --=C2=A0
>> 2.20.1
>>
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>>
> =

> -- =

> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7200536436417154825==--
