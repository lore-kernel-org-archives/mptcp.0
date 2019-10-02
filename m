Content-Type: multipart/mixed; boundary="===============8922363891267500848=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp:options: merge two holes in one
Date: Wed, 02 Oct 2019 19:22:18 +0200
Message-ID: <1b587ae8-4689-191f-6159-bcdab38e2ac2@tessares.net>
In-Reply-To: 85133594831c1b5aabe5210520948ae4b6046d47.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1991

--===============8922363891267500848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 02/10/2019 19:19, Peter Krystad wrote:
> On Wed, 2019-10-02 at 18:40 +0200, Matthieu Baerts wrote:
>> Instead of having two u8 not fully used, we switch to one u16 with only
>> one "__unused" variable.
>>
>> I guess we will want to optimise this code in
>> 'struct tcp_options_received' to use even more unions and reduce the
>> structure size, e.g. we cannot receive an MP_CAPABLE option and an
>> MP_JOIN one, etc.
> =

> Since this struct needs to be cleaned up and re-arranged anyway I'm
> indifferent whether this patch gets merged or not, it's not saving any sp=
ace
> as is.
> =

> The fields were organized the way they are to group the DSS option fields
> seperately from the ADD/RM_ADDR fields.

Indeed, if we plan to have a clean up soon, no need to apply this patch!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8922363891267500848==--
