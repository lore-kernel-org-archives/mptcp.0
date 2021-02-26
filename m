Content-Type: multipart/mixed; boundary="===============2749764339558317818=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/5] move to next addr when
 timeout
Date: Fri, 26 Feb 2021 08:58:50 +0100
Message-ID: <c5e12e4b-30b4-72d5-82d4-79053a881dd4@tessares.net>
In-Reply-To: CA+WQbwsMGQaDeAGc6DQBQvQecDHBQ8Dr6xaSsG1kfrfniOxpig@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7962

--===============2749764339558317818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 26/02/2021 04:42, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B42=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:01=E5=86=99=E9=
=81=93=EF=BC=9A
>> Tests + export have been queued!
> =

> I'm sorry to bring you extra work and trouble. But my patches on the
> export/20210225T204843 branch still need to be adjusted the order.
> =

> This series "move to next addr when timeout" should be put after the
> series "move to next addr and testcases" like this:

I can sure change the order but do we need to change it because some =

patches depends on others that are set after?

I should certainly explain why it is in this order:

- Initially I put the "rm list" series

- Then I added "mptcp: free resources when the port number is =

mismatched" and "mptcp: drop unused subflow in =

mptcp_pm_subflow_established" because they were looking like fixes for =

net-next

- Then I had to put "move to next addr when timeout" series before "rm =

list" because some patches had to be inserted before "mptcp: drop unused =

subflow in mptcp_pm_subflow_established"

But I can understand if the dependences are not OK. If it is, that's not =

an issue to change the order. If not, I guess we can leave it like that. =

We will end up sending everything at the next merge window anyway.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2749764339558317818==--
