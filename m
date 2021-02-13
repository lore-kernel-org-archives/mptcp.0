Content-Type: multipart/mixed; boundary="===============7029048794713854100=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/8] mptcp: Add genl events for
 connection info
Date: Sat, 13 Feb 2021 14:23:26 -0800
Message-ID: <20210213.142326.2016470334339829024.davem@davemloft.net>
In-Reply-To: b89e4be5-cac-af1d-1c1-2ce92fa55e10@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7798

--===============7029048794713854100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Fri, 12 Feb 2021 20:46:30 -0800 (PST)

> On Fri, 12 Feb 2021, Mat Martineau wrote:
> =

>> This series from the MPTCP tree adds genl multicast events that are
>> important for implementing a userspace path manager. In MPTCP, a path
>> manager is responsible for adding or removing additional subflows on
>> each MPTCP connection. The in-kernel path manager (already part of the
>> kernel) is a better fit for many server use cases, but the additional
>> flexibility of userspace path managers is often useful for client
>> devices.
>>
>> Patches 1, 2, 4, 5, and 6 do some refactoring to streamline the
>> netlink
>> event implementation in the final patch.
>>
>> Patch 3 improves the timeliness of subflow destruction to ensure the
>> 'subflow closed' event will be sent soon enough.
>>
>> Patch 7 allows use of the GENL_UNS_ADMIN_PERM flag on genl mcast
>> groups
>> to mandate CAP_NET_ADMIN, which is important to protect token
>> information
>> in the MPTCP events. This is a genetlink change.
>>
> =

> David -
> =

> I noticed that this series got merged to net-next and shows as
> "Accepted" in patchwork:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D0a2f6b32cc45e3918321779fe90c28f1ed27d2af
> =

> =

> However, somehow patch 7 did not propagate through the netdev list and
> does not show up in patchwork or the merged series!

I did put patch 7 into the commit, so no worries...
--===============7029048794713854100==--
