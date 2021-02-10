Content-Type: multipart/mixed; boundary="===============1252917187537977065=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] mptcp: improve mptcp release
 callback
Date: Wed, 10 Feb 2021 12:37:00 +0100
Message-ID: <d665c726-e2d4-0fa6-7613-b28f06cdf14b@tessares.net>
In-Reply-To: cover.1612869198.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7745

--===============1252917187537977065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 09/02/2021 12:42, Paolo Abeni wrote:
> The current callback implementation is probe to some race
> and still use some suboptimal code from older times.
> =

> This series clean-up the code a bit, fixing the race
> and hopefully simplifying future wider usage of delegated
> actions
> =

> Paolo Abeni (3):
>    mptcp: factor out __mptcp_retrans helper()
>    mptcp: fix race in release_cb
>    mptcp: clean-up the rtx path.

Thank you for the patches and the reviews!

It is now in our tree without a dot at the end of the last patch' =

subject and Mat's RvB tags:

- 1a97b665b9ee: mptcp: factor out __mptcp_retrans helper()
- f1c293d570e1: mptcp: fix race in release_cb
- 711d7b99ea0a: mptcp: clean-up the rtx path
- Results: b72113120e91..9c096197d99f

Tests + export are all good!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net


--===============1252917187537977065==--
