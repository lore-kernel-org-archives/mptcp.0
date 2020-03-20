Content-Type: multipart/mixed; boundary="===============0286063071397343679=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] net: mptcp: don't hang in
 mptcp_sendmsg() after TCP fallback
Date: Fri, 20 Mar 2020 16:54:45 +0100
Message-ID: <b4cc3997-c4d8-2f7c-30c8-1fb6922a910b@tessares.net>
In-Reply-To: 3121516743a4acdb67799565d0251531092244e7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4020

--===============0286063071397343679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/03/2020 23:48, Paolo Abeni wrote:
> On Thu, 2020-03-19 at 22:45 +0100, Davide Caratti wrote:
>> it's still possible for packetdrill to hang in mptcp_sendmsg(), when the
>> MPTCP socket falls back to regular TCP (e.g. after receiving unsupported
>> flags/version during the three-way handshake). Adjust MPTCP socket state
>> earlier, to ensure correct functionality of mptcp_sendmsg() even in case
>> of TCP fallback.
>>
>> Fixes: 767d3ded5fb8 ("net: mptcp: don't hang before sending 'MP capable =
with data'")
>> Fixes: 1954b86016cf ("mptcp: Check connection state before attempting se=
nd")
>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> =

> LGTM, thanks Davide!
> =

> Acked-by: Paolo Abeni <pabeni(a)redhat.com>

LGTM too, thanks Davide and Paolo!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
--===============0286063071397343679==--
