Content-Type: multipart/mixed; boundary="===============8524833854031185221=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash-to: "mptcp: push pending frames
 when subflow has free space"
Date: Fri, 11 Dec 2020 08:32:25 +0100
Message-ID: <63e16623-ebfb-91d9-6abc-814eef570e38@tessares.net>
In-Reply-To: c389f95f768ed57163765418c1f1670e08bba8e1.1607639386.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7147

--===============8524833854031185221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 10/12/2020 23:32, Paolo Abeni wrote:
> whoops, checking the free space on the wrong sock

Good catch, thank you for the patch and the review!

- 02754ad8b65e: "squashed" in mptcp: push pending frames when subflow =

has free space
- Results: 2f380236959a..af3a2ae8147a

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8524833854031185221==--
