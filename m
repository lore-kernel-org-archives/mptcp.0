Content-Type: multipart/mixed; boundary="===============5499647843293788582=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp:basic: check for v6 family
Date: Wed, 16 Oct 2019 18:44:21 +0200
Message-ID: <f640c03e-4818-8192-d666-190ebb81dde6@tessares.net>
In-Reply-To: d0182187ade8c29785e14115465146280842f420.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2191

--===============5499647843293788582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 16/10/2019 18:28, Peter Krystad wrote:
> On Wed, 2019-10-16 at 18:15 +0200, Matthieu Baerts wrote:
>> Instead of by default taking IPv6 if it is not v4.
>>
>> I don't know exactly what are the recommendations about that but it
>> seems we can often see code checking 'if v4' then 'else if v6', not
>> checking 'if v4' then 'else it is v6'.
> =

> In this situation I think it is OK to use 'else it is v6' because this co=
de is
> within the module and we know the field is set correctly (i.e. if local_v=
alid
> is set then local_family is set to one or the other). That has been my
> approach: use "else if v6" when the value comes from elsewhere. But YMMV.

Thank you for this comment.
Sounds good to me not to have the "else if v6" as long as we are careful =

with who can set this family :-)

We can drop the patch then.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5499647843293788582==--
