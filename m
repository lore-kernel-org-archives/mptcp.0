Content-Type: multipart/mixed; boundary="===============7935403848214793932=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fallback in case of simultaneous
 connect
Date: Mon, 15 Jun 2020 17:06:01 +0200
Message-ID: <81ef8140-4840-66a7-45d6-4134366492da@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2006111554250.63157@adevaraj-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4679

--===============7935403848214793932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Mat,

On 12/06/2020 00:57, Mat Martineau wrote:
> On Thu, 11 Jun 2020, Davide Caratti wrote:
> =

>> when a MPTCP client tries to connect to itself, tcp_finish_connect() is
>> never reached. Because of this, depending on the socket current state,
>> multiple faulty behaviours can be observed:

(...)

> Thanks for the v2 Davide, looks good to me.

Thank you for the patch and the review!

Just added after "net: mptcp: improve fallback to TCP":

- 295da4ec8264: mptcp: fallback in case of simultaneous connect

(I replaced "BugFixes:" with "Closes:" tag to have the reference in Github.)

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7935403848214793932==--
