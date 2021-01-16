Content-Type: multipart/mixed; boundary="===============2536224550948802478=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: re-enable sndbuf
 autotune"
Date: Sat, 16 Jan 2021 09:58:27 +0100
Message-ID: <835b7ace-b8f3-799b-7639-0135f2ff969d@tessares.net>
In-Reply-To: b12a934d3ccfa77941c04f19a61fbf02fe733537.1610730637.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7404

--===============2536224550948802478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 15/01/2021 18:11, Paolo Abeni wrote:
> In the current code there are a bunch of bugs, very
> apparent in unidirectional stream tests with a single
> flow- which are not covered by the self-test unfortunatelly:
> =

> __mptcp_clean_una() can clear SOCK_NOSPACE, since that can happen
> before tcp_data_snd_check()/tcp_new_space()/subflow_write_space,
> we end-up with no autotune.
> =

> subflow_write_space() can clear SOCK_NOSPACE when subflow can send
> but not the msk, that is wrong and can cause hangup.
> =

> The fix is moving the msk wake in subflow_write_space()
> =

> Commit message should be updated replacing:

(...)

Thank you for this patch and the review!
I had to do a minor fix, nothing important, please see below.

- f8a37f96887a: "squashed" in "mptcp: re-enable sndbuf autotune"
- 773ad5e3482f: commit message update
- 4141dc13f017: mptcp: fix compilation warning
- Results: 49b1f1e13b2b..dd65d1dcd819

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2536224550948802478==--
