Content-Type: multipart/mixed; boundary="===============5937614250648807401=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp:
 add link failure test case"
Date: Thu, 22 Oct 2020 16:57:10 +0200
Message-ID: <fa59c2bd-cce6-1c98-82c8-b6e13f375972@tessares.net>
In-Reply-To: 10330cb566261a70d0684856a9b468edcd8c4a05.1603337099.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6406

--===============5937614250648807401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 22/10/2020 05:47, Geliang Tang wrote:
> Change run_tests()'s test_linkfail as an optional argument, and set it's
> default value to 0.

To be honest, I don't know what we should do here: either we only have =

explicit parameters or we use the default ones most of the time.
For example, I see that the 3 first parameters are always the same ($ns1 =

$ns2 10.0.1.1). Do we need to define them each time?

Maybe clearer if we always set them but in this case it is not really =

clearer if you just have:

   run_tests 0 0 0 fast

Except the last one, it is not obvious what they are referring to :)

Alternative solutions:

   run_tests linkfail 0 0 fast
   linkfail=3D1 run_tests

Or maybe we don't need to care because it is "just" a script for some =

selftests!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5937614250648807401==--
