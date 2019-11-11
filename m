Content-Type: multipart/mixed; boundary="===============4505702298265600853=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/4] mptcp: disable mptcp when md5sig is set on
 socket
Date: Mon, 11 Nov 2019 18:06:08 +0100
Message-ID: <f00e2244dce7dd17b11fb204340537b172814065.camel@redhat.com>
In-Reply-To: cover.1573488686.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2470

--===============4505702298265600853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> As per last public mtg discussion, md5sig will cause TCP option space
> exaustion. Without md5sig we can't exhaust the TCP option space.
> =

> This series explcitly disable MPTCP when md5sig is set, and cleanup
> later option len checks with the assumption that TCP option space exhaust=
ion
> is not expected - add a single WARN_ON() for that.
> =

> Paolo Abeni (1):
>   mptcp: move mp_capable initialization at subflow_init_req() start
>   mptcp: disable on req sk if MD5SIG is enabled
>   mptcp: warn once if exceeding tcp opt space for dss/mp_capable
>   mptcp: remove unneeded check in mptcp_established_options_mp()
> =

>  net/mptcp/subflow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Addenda:
- I dumbly edited this series manually and ended-up with the wrong
prefix on this cover letter [PATCH 1/4] instead of [PATCH 0/4], I'm
sorry.
- the selftests run successful on a build from the patched git
tree@"mptcp: add basic kselftest for mptcp".
- I'm wondering about adding an explicit self-test vs md5sig - easier
way would be checking the MIB counters after the transfer completes
successfully.

/P

--===============4505702298265600853==--
