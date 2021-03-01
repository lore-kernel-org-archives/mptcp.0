Content-Type: multipart/mixed; boundary="===============0251757500429338029=="
MIME-Version: 1.0
From: David Ahern <dsahern at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH iproute2-next] mptcp: add support for port based
 endpoint
Date: Sun, 28 Feb 2021 17:16:51 -0700
Message-ID: <b76abf00-8883-8215-706f-4d1b407b82ef@gmail.com>
In-Reply-To: 868cfad6ab2fbd7f4b2ac6522b3ec62fce858fed.1613767061.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7970

--===============0251757500429338029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/19/21 1:42 PM, Paolo Abeni wrote:
> The feature is supported by the kernel since 5.11-net-next,
> let's allow user-space to use it.
> =

> Just parse and dump an additional, per endpoint, u16 attribute
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  ip/ipmptcp.c        | 16 ++++++++++++++--
>  man/man8/ip-mptcp.8 |  8 ++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> =



applied to iproute2-next. Thanks


--===============0251757500429338029==--
