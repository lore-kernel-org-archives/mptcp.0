Content-Type: multipart/mixed; boundary="===============3708809740529596213=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/3] add MP_PRIO,
 MP_FAIL and MP_FASTCLOSE suboptions handling
Date: Tue, 16 Jun 2020 17:18:56 +0200
Message-ID: <04ae76d9-231a-de8e-ad33-1e4e80bb314c@tessares.net>
In-Reply-To: cover.1592289629.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4700

--===============3708809740529596213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang

On 16/06/2020 08:47, Geliang Tang wrote:
> Add handling for sending and receiving the MP_PRIO, MP_FAIL, and
> MP_FASTCLOSE suboptions.

Thank you for the patches!

Unfortunately, I don't think it would be wise to accept them now: for =

the moment, these suboptions are ignored at the reception. If we accept =

them and change some variables like you did, we would need to make sure =

the kernel is still acting correctly. In other words, we would need tests:
* For MP_PRIO, there are still quite some works to do regarding the =

scheduling of the packets between the different MPTCP subflows to do =

before supporting this.
* For MP_FAIL, we should forward the info to the path manager.
* For MP_FASTCLOSE, we should close connections and ACK this.

Also, net-next is closed for the moment: =

http://vger.kernel.org/~davem/net-next.html

I would suggest you to discuss about that on MPTCP mailing list. We also =

have meetings every Thursday. New devs are always welcome to contribute =

to new features and bug-fixes!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3708809740529596213==--
