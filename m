Content-Type: multipart/mixed; boundary="===============7068730994665094077=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Part 2 - Cover Letter
Date: Fri, 17 Jan 2020 16:58:07 +0100
Message-ID: <8c780fbe-d06a-3959-c360-66908a50d18b@tessares.net>
In-Reply-To: alpine.OSX.2.21.2001161729180.45790@ndoyal-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3393

--===============7068730994665094077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Mat,

On 17/01/2020 02:33, Mat Martineau wrote:
> =

> On Thu, 16 Jan 2020, Christoph Paasch wrote:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Jan 16, 2020, at 10:07 AM, Christoph P=
aasch =

>> <cpaasch(a)apple.com> wrote:
>>
>> Hello,
>> here is the proposed cover-letter for Part 2. I assume that it will be =

>> "v3" as Mat already sent out the v2 before Christmas.
>>
> =

> Yes, it should be v3.
> =

> Cover letter additions for RFC8684 look good, thanks Christoph.

For me too. Just a few questions here below, only details.

>> Please let me know what should be changed.
>>
>> =3D=3D=3D=3D=3D=3D
>>
>> Subject: [PATCH net-next v3 ...]=C2=A0Multipath TCP part 2: Single subfl=
ow

Should we change the title to?

   Multipath TCP part 2: Single subflow & RFC8684 support

>> v2 -> v3: Added RFC8684-style handshake and some minor fixes

Do you think that we should give more detail about this change? I mean =

we said in the previous cover letter that we were going to have 3 parts =

but here we decided to merge the last two parts.

Maybe adding something like: "(see below fore more details)"

>> v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series
>>
>> This set adds MPTCP connection establishment, writing & reading MPTCP
>> options on data packets, a sysctl to allow MPTCP per-namespace, and self
>> tests. This is sufficient to establish and maintain a connection with a
>> MPTCP peer, but will not yet allow or initiate establishment of
>> additional MPTCP subflows.
>>
>> We also add the necessary code for the RFC8684-style handshake.
>> RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
>> version 1.
>>
>> The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
>> deployments are currently based on RFC 6824, future deployments will be
>> migrating to MPTCP version 1. 3GPP's 5G standardization also solely =

>> supports RFC 8684. Also, we believe that this initial submission of MPTCP

(detail: to avoid another "Also", should we say: "In addition"?)

>> will be cleaner by solely supporting RFC 8684. If later on support for
>> the old MPTCP-version is required it can always be added in the future.
>>
>> The major difference between RFC 8684 and RFC 6824 is that it has a =

>> better
>> support for servers using TCP SYN-cookies by reliably retransmitting the
>> MP_CAPABLE option.
>>
>>
> I forgot the Twitter reference! Matth, any good ideas for a joke? :-)

If you agree with that, I would propose to say something like this but =

only for this v3 (not after if there is no reaction) ;-)

     Before ending this cover letter with some refs, it is worth =

mentioning that we promise David Miller that merging this series will be =

rewarded by Twitter dopamine hits :-D

(if the English is correct)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7068730994665094077==--
