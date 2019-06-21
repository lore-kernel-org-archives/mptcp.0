Content-Type: multipart/mixed; boundary="===============1576914561448042833=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix remaining checkpatch issue
Date: Fri, 21 Jun 2019 11:09:17 +0200
Message-ID: <c37f94df-5599-1775-fa46-b7ddc5f388b7@tessares.net>
In-Reply-To: alpine.OSX.2.21.1906200945271.44348@kdmease-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1437

--===============1576914561448042833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 20/06/2019 18:45, Mat Martineau wrote:
> =

> On Thu, 20 Jun 2019, Matthieu Baerts wrote:
> =

>> A typo (with 'length') was introduced when fixing another issue.
>>
>> Fixes: 233967ed7653 (mptcp: fix checkpatch issues)
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> =

> Looks good, please squash.

Thank you for this review!

- 52083ddbf0bc: "squashed" in "mptcp: Write MPTCP DSS headers to
outgoing data packets"
- no signed-off added
- 894e99705150: conflict in t/mptcp-Implement-MPTCP-receive-path
- 841e81cf55fc..eefaf0b9e6f7: results (no diff)

Cheers,
Matt

> =

>> ---
>>
>> Notes:
>> =C2=A0=C2=A0 Can be squashed in:
>> =C2=A0=C2=A0=C2=A0=C2=A0 mptcp: Write MPTCP DSS headers to outgoing data=
 packets
>>
>> net/mptcp/options.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 625cd93fb9a8..532482bbbc2a 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -241,7 +241,7 @@ static bool mptcp_established_options_dss(struct
>> sock *sk, struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0if (mpext && mpext->use_ack) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ack_size =3D TCPOLEN_MPTCP_DS=
S_ACK64;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add kind/lenght/subtype/f=
lag overhead if mapping is not
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add kind/length/subtype/f=
lag overhead if mapping is not
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * populated
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dss_size =3D=3D 0)
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

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1576914561448042833==--
