Content-Type: multipart/mixed; boundary="===============7150202548320132965=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: be careful on subflows shutdown
Date: Thu, 26 Nov 2020 18:34:10 +0100
Message-ID: <b0eb995d-41ed-a42f-5f5e-9c0acd2481e8@tessares.net>
In-Reply-To: 0e80f1282034868082de4b9a76c8f5fde867f840.1606329599.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6957

--===============7150202548320132965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 25/11/2020 19:41, Paolo Abeni wrote:
> When the workqueue disposes of the msk, the subflows can still
> receive some data from the peer after __mptcp_close_ssk()
> completes.
> =

> The above could trigger a race between the msk receive path and the
> msk destruction. Acquiring the mptcp_data_lock() in __mptcp_destroy_sock()
> will not save the day: the rx path could be reached even after msk
> destruction completes.
> =

> Instead use the subflow 'disposable' flag to prevent entering
> the msk receive path after __mptcp_close_ssk().
> =

> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch!

Just applied at the bottom of the tree with a small modification =

regarding the last comment as discussed on IRC.

- 3b454e7a584d: mptcp: be careful on subflows shutdown
- Result: ba6c5ecb4ea5..3f0906ebbcbb

Export has already been done.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7150202548320132965==--
