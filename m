Content-Type: multipart/mixed; boundary="===============6086913439099157963=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 4/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 22:01:49 +0200
Message-ID: <987d8986-e3b7-b24f-f2b7-7fac58520a8b@tessares.net>
In-Reply-To: 20190615193754.hmqmi6u7ik4lh2qn@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1404

--===============6086913439099157963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 15/06/2019 21:37, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>   =

>>  static inline bool mptcp_syn_options(struct sock *sk, unsigned int *siz=
e,
>> -				     struct mptcp_out_options* opts)
>> +				     struct mptcp_out_optionsi *opts)
> =

> I don't think you wanted to append that 'i' here :-)

Wow, good catch!

I have to admit that I didn't check each patch individually. I created
one modification from each topic/commit to ease the application later.
Then I sent everything in one.

Now everybody will know which editor I used! And yes, people will say it
would not have happened with emacs :-D

I am going to resend this individual patch only, not the rest to avoid
spamming people :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6086913439099157963==--
