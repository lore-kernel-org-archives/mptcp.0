Content-Type: multipart/mixed; boundary="===============6389647926228236897=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix length of ADD_ADDR with port
 suboption
Date: Thu, 04 Mar 2021 11:15:17 +0100
Message-ID: <547328c61d97627fc32820de2234973a0ea29416.camel@redhat.com>
In-Reply-To: CA+WQbwsWDangvJK6GDQOas17k9yQ6qTSNAk9zx7LRnZohyz=wg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8023

--===============6389647926228236897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello Geliang, thanks for reviewing!

On Thu, 2021-03-04 at 18:03 +0800, Geliang Tang wrote:
> I think no need to add these two lines. WDYT?

right, 'len' is no more used after the call to

mptcp_option(MPTCPOPT_ADD_ADDR, len, ...)

I will remove them and send a v2.
-- =

davide


=09

--===============6389647926228236897==--
