Content-Type: multipart/mixed; boundary="===============0579059413882267982=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 4/7] mptcp: pass subflow socket to a few
 helpers
Date: Tue, 19 Jan 2021 22:31:43 +0100
Message-ID: <38c04682-84b0-0388-4894-885f9ca97cd5@tessares.net>
In-Reply-To: 20210114173654.7618-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7427

--===============0579059413882267982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 14/01/2021 18:36, Florian Westphal wrote:
> Pass the first/initial subflow to the existing functions so they can
> pass this on to the notification handler in the next patch.

(tiny detail: I don't know if it is important but we don't do that "in =

the next patch" but in the last one of the series. But I am sure it is =

not an issue.)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0579059413882267982==--
