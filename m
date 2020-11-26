Content-Type: multipart/mixed; boundary="===============6584922244437003902=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 5/9] mptcp: add port number
 announced check
Date: Thu, 26 Nov 2020 11:06:49 +0100
Message-ID: <c7c4bf18-5493-02e0-489a-82245e9425f1@tessares.net>
In-Reply-To: ec6c4f757b368a4a22577d7d2de616ea530fbfd5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6946

--===============6584922244437003902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 26/11/2020 11:03, Davide Caratti wrote:
> the above script will probably generate a test failure on the outbound
> MP_JOIN synack as long as a patched kernel does not crash anymore. What
> we can do is to add a scenario that verifies the correct behavior _
> according to  RFC =C2=A7 3.2:

For me it would be good to have both but only merge the one you shared =

when the fix is available :)

In general, I think it is good to add all the ones we have to fix issues =

in the "regression" dir. Even if they are simple or specific to one issue.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6584922244437003902==--
