Content-Type: multipart/mixed; boundary="===============5169690233345997303=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/1] Add MPTCP code to work with the modified TCP
 code
Date: Thu, 01 Mar 2018 11:20:41 -0800
Message-ID: <20180301192041.GB41258@MacBook-Pro-4.local>
In-Reply-To: 1519865392-10321-2-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 333

--===============5169690233345997303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/02/18 - 16:49:52, rao.shoaib(a)oracle.com wrote:
> From: Rao Shoaib <rao.shoaib(a)oracle.com>
> =

> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
> ---
>  include/net/mptcp.h          | 1474 +++++++++++++++++++++
>  include/net/mptcp_v4.h       |   56 +
>  include/net/mptcp_v6.h       |   56 +
>  include/net/netns/mptcp.h    |   52 +
>  net/Kconfig                  |    1 +
>  net/Makefile                 |    1 +
>  net/mptcp/Kconfig            |  129 ++
>  net/mptcp/Makefile           |   22 +
>  net/mptcp/mptcp_balia.c      |  267 ++++
>  net/mptcp/mptcp_binder.c     |  487 +++++++
>  net/mptcp/mptcp_coupled.c    |  270 ++++
>  net/mptcp/mptcp_ctrl.c       | 2981 ++++++++++++++++++++++++++++++++++++=
++++++
>  net/mptcp/mptcp_fullmesh.c   | 1877 ++++++++++++++++++++++++++
>  net/mptcp/mptcp_input.c      | 2970 ++++++++++++++++++++++++++++++++++++=
+++++
>  net/mptcp/mptcp_ipv4.c       |  345 +++++
>  net/mptcp/mptcp_ipv6.c       |  316 +++++
>  net/mptcp/mptcp_ndiffports.c |  169 +++
>  net/mptcp/mptcp_ofo_queue.c  |  177 +++
>  net/mptcp/mptcp_olia.c       |  309 +++++
>  net/mptcp/mptcp_output.c     | 1837 ++++++++++++++++++++++++++
>  net/mptcp/mptcp_pm.c         |  178 +++
>  net/mptcp/mptcp_redundant.c  |  268 ++++
>  net/mptcp/mptcp_rr.c         |  301 +++++
>  net/mptcp/mptcp_sched.c      |  597 +++++++++
>  net/mptcp/mptcp_wvegas.c     |  268 ++++
>  25 files changed, 15408 insertions(+)

Please read the sections "Separate your changes" and "E-mail size" of
process/submitting-patches.rst.


Christoph


--===============5169690233345997303==--
