Content-Type: multipart/mixed; boundary="===============0211913198432256579=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Mon, 07 Sep 2020 11:51:53 +0200
Message-ID: <7a7efbbd87e07aa1a1178ae0c4a2c56b237b820d.camel@redhat.com>
In-Reply-To: CA+WQbwttLmaW2U_ouuMwKXtKW-6RF=CXGLPdeHWhbTpTA7NRgw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5745

--===============0211913198432256579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-09-04 at 13:07 +0800, Geliang Tang wrote:
> And I want to commit patch 4/8 "mptcp: fix every subflow's local_id is ze=
ro"
> and 5/8 "mptcp: fix subflow's remote_id is zero issue" directly to -net a=
s Paolo
> suggested.

I think you can go ahead and post them upstream. The sooner, the better
- than we will have to wait for -net merge into net-next to push the
patches depending on the above ones.

> Some code about subflow's remote_id fixing in the commit "mptcp:
> add the incoming RM_ADDR support" should be put together in patch 5/8.
> So in the squash-to patch, I drop the original subflow's remote_id fixing=
 code.
> =

> Please give me some suggestions about my squash-to patch.

LGTM ;)

Thanks,

Paolo

--===============0211913198432256579==--
