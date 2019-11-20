Content-Type: multipart/mixed; boundary="===============3193324156426395629=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] mptcp: warn once if exceeding tcp opt
 space for dss/mp_capable
Date: Wed, 20 Nov 2019 18:38:02 +0100
Message-ID: <48a7b32a32fe9efdfbfdef7b5622ab23828a039f.camel@redhat.com>
In-Reply-To: 9bde8b1c-d71b-c826-9e83-0db1602035cd@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2624

--===============3193324156426395629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 18:27 +0100, Matthieu Baerts wrote:
> @Paolo: I *think* that the first patches of this series were not based =

> at the end of the series but at the end of part 2 (kselftest =

> introduction). =


Every patch was based/applied locally just after the related 'squash-
to' patch, hoping to minimize the resulting conflicts, I see that did
not work very well, sorry.

> I had to add some extra code and resolve some conflicts =

> with what I hope would be what you had in mind :-)
> Please see the different conflict resolution and the extra commit here =

> below, especially 7d8b4fe573fb which I guess there are better ways to do =

> but I hope the code is OK.
> =

> - 3ce88efe9902: "squashed" patch 1/4 (or 1/1 :) ) in "mptcp: Create =

> SUBFLOW socket for incoming connections"
> - 9c58989db059: "squashed" patch 2/4 in "mptcp: Create SUBFLOW socket =

> for incoming connections"
> - 946c99f17805: "squashed" patch 3/4 in "mptcp: Write MPTCP DSS headers =

> to outgoing data packets"
> - 27a10380b320: conflict in t/mptcp-Implement-MPTCP-receive-path
> - a17134e4116a: conflict in t/mptcp-Add-ADD_ADDR-handling
> - 7d8b4fe573fb: extra code: take extra established options into account
> - 34c0738e7ed4: conflict in =

> t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
> - 63e57f2facbc: conflict in =

> t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
> - 0f2c93ad449d: "squashed" patch 4/4 in "mptcp: Add handling of outgoing =

> MP_JOIN requests"
> - 84cd31e06aaa: "Signed-off-by" + "Co-developed-by"
> - aad61f16b421: conflict in t/mptcp-increment-MIB-counters-in-a-few-places
> - 84af4075aa4f..e73eef882a05: result
> =

> Tests are still all passing!

Ok, will review and report here.

Thank you,

Paolo

--===============3193324156426395629==--
