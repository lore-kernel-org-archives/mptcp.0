Content-Type: multipart/mixed; boundary="===============2268765140631261657=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: refactor shutdown and close"
Date: Thu, 15 Oct 2020 16:00:19 +0200
Message-ID: <b926d53fa15a1e9c11de69a10a721b4ec85e926a.camel@redhat.com>
In-Reply-To: ec5396bf43b34115b9818099983a7f6bc25e7388.1602768332.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6317

--===============2268765140631261657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 15:26 +0200, Paolo Abeni wrote:
> Currently we can miss the msk timeout event in several
> circumstances (e.g. no outstanding data).
> =

> Let's use a separate timer to keep track of the timeout
> after close().
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

LGTM.

this is tested with the following script:
https://paste.centos.org/view/4ff84dae

(not sure if it's worth adding to the current packetdrill, because the
test takes TCP_TIMEWAIT_LEN to pass)

-- =

davide

--===============2268765140631261657==--
