Content-Type: multipart/mixed; boundary="===============0493812416397862994=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/8] mptcp: Add genl events for
 connection info
Date: Fri, 12 Feb 2021 20:52:07 -0800
Message-ID: <76f164fa-113d-8ae0-331c-705696301d6f@linux.intel.com>
In-Reply-To: b89e4be5-cac-af1d-1c1-2ce92fa55e10@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7797

--===============0493812416397862994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 12 Feb 2021, Mat Martineau wrote:

> On Fri, 12 Feb 2021, Mat Martineau wrote:
>
>> This series from the MPTCP tree adds genl multicast events that are
>> important for implementing a userspace path manager. In MPTCP, a path
>> manager is responsible for adding or removing additional subflows on
>> each MPTCP connection. The in-kernel path manager (already part of the
>> kernel) is a better fit for many server use cases, but the additional
>> flexibility of userspace path managers is often useful for client
>> devices.
>> =

>> Patches 1, 2, 4, 5, and 6 do some refactoring to streamline the netlink
>> event implementation in the final patch.
>> =

>> Patch 3 improves the timeliness of subflow destruction to ensure the
>> 'subflow closed' event will be sent soon enough.
>> =

>> Patch 7 allows use of the GENL_UNS_ADMIN_PERM flag on genl mcast groups
>> to mandate CAP_NET_ADMIN, which is important to protect token information
>> in the MPTCP events. This is a genetlink change.
>> =

>
> David -
>
> I noticed that this series got merged to net-next and shows as "Accepted"=
 in =

> patchwork:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D0a2f6b32cc45e3918321779fe90c28f1ed27d2af
>
>
> However, somehow patch 7 did not propagate through the netdev list and do=
es =

> not show up in patchwork or the merged series!
>
>
> It did get archived on the cc'd mptcp list =

> (https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/KBY6UI=
FETMXCAOHNXQLYWKXNCHSGJ7AG/) =

> so hopefully your directly-addressed copy also arrived. The missing patch =

> won't cause a build error but does lead to a token getting exposed to =

> non-admin users.
>
> I will re-send it with an extra note about where it originally fit in.

Ok, please disregard. When I went to prepare the patch to re-send I found =

that Dave was a step ahead of me, and the code is in fact in the tree. =

Thanks for handling the issue.


--
Mat Martineau
Intel
--===============0493812416397862994==--
