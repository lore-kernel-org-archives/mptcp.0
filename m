Content-Type: multipart/mixed; boundary="===============4848173217847714288=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Use sk_family field in the mptcp_sock for
 address family.
Date: Tue, 05 Nov 2019 13:57:54 -0800
Message-ID: <alpine.OSX.2.21.1911051344520.27697@cavianch-mobl1.amr.corp.intel.com>
In-Reply-To: 56f99f8699f42ae8f0cb61e30db157cd12c2eb06.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2407

--===============4848173217847714288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 5 Nov 2019, Paolo Abeni wrote:

> On Mon, 2019-11-04 at 21:26 -0800, Peter Krystad wrote:
>> It was not necessary to add a family field to mptcp_sock as it is
>> a wrapper around a struct sock, and sk_family is set correctly when
>> the msk is created as a result of a socket() call.
>>
>> squashto: Associate MPTCP context with TCP socket
>>           mptcp: Implement basic path manager
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>
> LGTM, nice cleanup, thanks!
>
> It's unclear to me if I should update patchwork status, too ("Under
> review"? would that help?)
>

Looks good to me, too.

For handling patchwork status, I went to the upcoming meeting page to =

create a proposal - and found that Matthieu has already done it :)

--
Mat Martineau
Intel
--===============4848173217847714288==--
