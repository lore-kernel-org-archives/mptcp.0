Content-Type: multipart/mixed; boundary="===============9009888266556638620=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 05/16] tcp: Add IPPROTO_SUBFLOW
Date: Tue, 09 Oct 2018 20:35:21 -0700
Message-ID: <alpine.OSX.2.21.1810092029371.4669@suryakri-mssb.amr.corp.intel.com>
In-Reply-To: CAKuKrBmcSV-++Xoygzd+pDLA7oD9-kv5A9wPOKT8oVVK36NSvg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 808

--===============9009888266556638620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 9 Oct 2018, Matthieu Baerts wrote:

> On Sat, Oct 6, 2018 at 1:04 AM Mat Martineau
> <mathew.j.martineau(a)linux.intel.com> wrote:
>>
>> From: Peter Krystad <peter.krystad(a)intel.com>
>>
>> IANA protocol numbers fit in a single byte, however the protocol field
>> of struct inet_protosw is an unsigned short so defining IPPROTO_SUBFLOW
>> as a 16-bit value greater than 0xFF with the same LSB as IPPROTO_TCP is
>> convenient for registering a unique protocol with inet_register_protosw()
>> that still transmits packets with IPPROTO_TCP as the protocol number.
>
> Should we then call it IPPROTO_TCP_SUBFLOW? :)
>

Hopefully we won't need a special IPPROTO_ for the subflows in the long =

run. It could be defined internally for kernel code with some checks to =

prevent userspace-owned sockets of this type. Since the MPTCP kernel code =

has complete control over the subflow sockets, maybe we could create =

regular TCP sockets and modify them before using them (kind of like ULP =

does, but without using the ULP infrastructure between an MPTCP socket and =

its subflows).

Mat


>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
>> ---
>>  include/uapi/linux/in.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>> index f65975c801e5..6986aecd0f46 100644
>> --- a/include/uapi/linux/in.h
>> +++ b/include/uapi/linux/in.h
>> @@ -78,6 +78,8 @@ enum {
>>  #define IPPROTO_MPLS           IPPROTO_MPLS
>>    IPPROTO_RAW =3D 255,           /* Raw IP packets                     =
  */
>>  #define IPPROTO_RAW            IPPROTO_RAW
>> +  IPPROTO_SUBFLOW =3D 262,       /* Multipath TCP (IPPROTO_TCP | 0x100)=
  */
>> +#define IPPROTO_SUBFLOW                IPPROTO_SUBFLOW
>>    IPPROTO_MAX
>>  };
>>  #endif
>> --
>> 2.19.1
>>
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>
>
>
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>
> Disclaimer: https://www.tessares.net/mail-disclaimer/
>

--
Mat Martineau
Intel OTC

--===============9009888266556638620==--
