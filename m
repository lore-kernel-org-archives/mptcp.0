Content-Type: multipart/mixed; boundary="===============6157139885311474346=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] ss: allow dumping MPTCP subflow information
Date: Wed, 22 Apr 2020 16:00:07 +0200
Message-ID: <55c6f64b-ee99-a82f-b37c-bf70b1df5fb4@tessares.net>
In-Reply-To: 2dd91483e09dc0a829928e8f5f6dc23f778d053e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4224

--===============6157139885311474346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 20/04/2020 19:10, Davide Caratti wrote:
> On Mon, 2020-04-20 at 18:47 +0200, Matthieu Baerts wrote:
>> Do you think we can also add what each of "MmBbJjecv" means? :-)
> =

> ... sure, even if it's painful as we are already in a .TP item :) I'm more
> worried about what to write as understandable description for 'sfseq'
> 'ssn_offset', and 'map_valid'.

Indeed, when looking at SS man page, I don't know where to explain that.
Or maybe:

   .B tcp-ulp-mptcp flags:[M<remote MP_CAPABLE>m<local =

MP_CAPABLE>J<remote MP_JOIN>j<local MP_JOIN>B<remote backup>b<local =

backup>e<fully established>c<connected>v<map valid>] =

token:<rem_token(rem_id)/loc_token(loc_id)> seq:<sn> sfseq:<ssn> =

ssnoff:<off> maplen:<maplen>

a bit like what is described for "skmem"?
But that's maybe too long?
Or a link to a doc stored somewhere?

> Can we do this in a separate patch, if it doesn't block the acceptance of
> 'iproute2' series?

Sure, I don't want to block this.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6157139885311474346==--
