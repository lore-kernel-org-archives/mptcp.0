Content-Type: multipart/mixed; boundary="===============4572582786961898867=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Wed, 12 Feb 2020 21:06:23 +0100
Message-ID: <50c041f1a2bc98d8888671a2b3eb3bcd06dd5117.camel@redhat.com>
In-Reply-To: 399de22d-d350-c509-e77c-ab89b7978b8a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3637

--===============4572582786961898867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 11:02 +0100, Matthieu Baerts wrote:
> Hi Davide,
> =

> On 12/02/2020 10:39, Davide Caratti wrote:
> > @Matthieu,
> > while we are at this, what do you expect for the "official" packetdrill
> > branch 'mptcp-net-next' [1]? can I do a pull request from my GH to that
> > one for those tests that are currently passing (e.g. mp_capable v1, TCP
> > fallback and DSN8/DACK8?)
> =

> I think you can directly work on this repo like you were doing with =

> yours. At least it looks somehow "official".

thanks! =


> Of course if you need some reviews, you can open pull requests.

... done, it's https://github.com/multipath-tcp/packetdrill/pull/1
I'm not merging it as-is, because probably DSS tests will need some make-
up after Florian's work on the DACK value - correct?

> You should have the write permissions. Please tell me if not.

I see write permissions, thanks!
-- =

davide

--===============4572582786961898867==--
