Content-Type: multipart/mixed; boundary="===============0011263566182892017=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 5/9] mptcp: add port number
 announced check
Date: Thu, 26 Nov 2020 11:01:36 +0100
Message-ID: <39f228e3-d112-263e-93c8-cd432fcde3cc@tessares.net>
In-Reply-To: 0bbf33c70b937d1040921260647b364b22a8a21d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6944

--===============0011263566182892017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Davide,

On 26/11/2020 10:56, Paolo Abeni wrote:
> On Wed, 2020-11-25 at 21:33 +0100, Davide Caratti wrote:

(...)

>> @Paolo, your analysis is correct: the server responds to the (d)evil
>> inbound "MP_JOIN syn" with a MP_JOIN synack having sender HMAC equal to
>> 0; the 3rd packet triggers the NULL dereference. >
> Thank you Davide, great work!

+1

> Could you please additionally merge the
> above drill in the packetdrill repo?

Please only merge it in mptcp-net-next when the fix patch is merged in =

our export branch :)

Of course, we can also merge it in another branch or in a special dir -- =

e.g. "in progress" -- or keep an opened PR!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0011263566182892017==--
