Content-Type: multipart/mixed; boundary="===============3002885318451915016=="
MIME-Version: 1.0
From: Florian Westphal <fwestpha at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/3] mptcp: only admit explicitly
 supported sockopt
Date: Thu, 11 Mar 2021 12:34:44 +0100
Message-ID: <4593ff4f-5056-8e54-6be5-733e6cd27101@redhat.com>
In-Reply-To: 5e465bd5f4b3f7e883e09e3f4bc5a566edba045f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8100

--===============3002885318451915016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 3/11/21 10:25 AM, Paolo Abeni wrote:
> Looks like 'SO_SNDTIMEO' still will not work as expected, because the
> setting is applied only to the first subflow, while
> mptcp_recvmsg()/mptcp_sendmsg() will look for the timeout value in the
> msk socket.
> =

> @Florian: do you think the above could be addressed by the sockopt()
> improvements?

Sure.

--===============3002885318451915016==--
