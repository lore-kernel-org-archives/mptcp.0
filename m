Content-Type: multipart/mixed; boundary="===============3811853913106310290=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 0/2] init ahmac and port of
 mptcp_options_received
Date: Mon, 19 Oct 2020 18:27:55 +0200
Message-ID: <7766357d-0838-1603-9967-8910aa312f65@tessares.net>
In-Reply-To: cover.1603102503.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6353

--===============3811853913106310290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 19/10/2020 12:23, Geliang Tang wrote:
> This patchset deals with initializations of mptcp_options_received's two
> fields, ahmac and port.
> =

> Geliang Tang (2):
>    mptcp: initialize mptcp_options_received's ahmac
>    mptcp: move mptcp_options_received's port initialization

Thank you for these two patches. They look good to me except one detail: =

these two patches are for -net and not net-next.

I don't know if it is alright for Jakub to apply them to -net or if it =

is clearer to re-send them with an updated subject.

If it is OK to apply them to -net without a re-submit, here is my:


Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>


Also, if you don't mind and while I am here, I never know: is it OK for =

you the maintainers to send one Acked/Reviewed-by for a whole series -- =

but then this is not reflected on patchwork -- or should we send one tag =

for each patch?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3811853913106310290==--
