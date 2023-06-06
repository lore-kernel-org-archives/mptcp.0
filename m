Received: from ms11p00im-qufo17281901.me.com (ms11p00im-qufo17281901.me.com [17.58.38.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53A1ED53
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1686077279;
	bh=j4FB9XcQl9rBzCWEd4AXEUFHHbkBsHJRkFfNBqTVCcM=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=wpOdWmMnUa01kq2Is6dzOeULKALcclUcurVvYGxYIykRpBSSdw7m1QZHDQGHQuaSJ
	 bUBKjRdGRg7bBCXmtEzx4n4xHxeMFOQK9xd1sLFZMrhXi0D0J8+XNh24B6SinZbGZw
	 FkCATfOhWaRKgAkp4jhtmc9lZ7uSqQmUAjDjPn0u/7GpRJSUVwLP863eKFC19qlB0y
	 35RwqNusQ1JBkqFJgtWTahz3wVlYhQPHk88rvHW7QxlgbwHANG9Yhj8AuRXQX+45UN
	 fvmCQQVTpWJW7tncgcxf3OME2rrQA5xguNn3rhX/ekXtqtcA81D3eJb3mzJKBr8HM8
	 EN6G6R6BwL2+w==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281901.me.com (Postfix) with ESMTPSA id 9578FD8043F;
	Tue,  6 Jun 2023 18:47:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
From: evanhensbergen@icloud.com
In-Reply-To: <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net>
Date: Tue, 6 Jun 2023 13:47:47 -0500
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>,
 regressions@lists.linux.dev,
 v9fs@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
 <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-GUID: Xi0UDUrLiKl2pa7R1Q_2WXvZNHACUmcD
X-Proofpoint-ORIG-GUID: Xi0UDUrLiKl2pa7R1Q_2WXvZNHACUmcD
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 adultscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306060160

Interesting - so looks like caches aren=E2=80=99t being used so curious =
that there is any impact at all from mostly cache-related patches!
Okay thanks, I=E2=80=99ll dig in and see what I can find.

      -Eric


> On Jun 6, 2023, at 10:08 AM, Matthieu Baerts =
<matthieu.baerts@tessares.net> wrote:
>=20
> Hi Eric,
>=20
> On 06/06/2023 16:49, Eric Van Hensbergen wrote:
>> thanks for the detailed report - I=E2=80=99ll have a look.
>=20
> Thank you for the quick reply!
>=20
> No hurry, we can also revert these patches in our tree for the time =
being.
>=20
>> Do you know off hand
>> what cache options for 9p are in use?
>=20
> Sorry, I'm not sure what to look at.
>=20
> In the VM, I see that this mount command is used:
>=20
>  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dan=
y \
>             virtme.guesttools /run/virtme/guesttools
>=20
> In virtme source, I can see these commands should be executed:
>=20
>  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dan=
y \
>             /dev/root /newroot/
>  mount -t 9p -o version=3D9p2000.L,trans=3Dvirtio,access=3Dany \
>        "virtme.initmount${tag:16}" "${!tag}"
>=20
> =46rom the VM, I can see:
>=20
>> # mount | grep 9p
>> /dev/root on / type 9p (ro,relatime,access=3Dany,trans=3Dvirtio)
>> virtme.guesttools on /run/virtme/guesttools type 9p =
(ro,relatime,access=3Dany,trans=3Dvirtio)
>> virtme.initmount0 on /mptcp_net-next type 9p =
(rw,relatime,access=3Dany,trans=3Dvirtio)
>=20
> And the VM is started using:
>=20
>> /usr/bin/qemu-system-x86_64 -fsdev =
local,id=3Dvirtfs1,path=3D/,security_model=3Dnone,readonly=3Don,multidevs=3D=
remap -device virtio-9p-pci,fsdev=3Dvirtfs1,mount_tag=3D/dev/root -fsdev =
local,id=3Dvirtfs5,path=3D/opt/virtme/virtme/guest,security_model=3Dnone,r=
eadonly=3Don,multidevs=3Dremap -device =
virtio-9p-pci,fsdev=3Dvirtfs5,mount_tag=3Dvirtme.guesttools -fsdev =
local,id=3Dvirtfs9,path=3D.,security_model=3Dnone,multidevs=3Dremap =
-device virtio-9p-pci,fsdev=3Dvirtfs9,mount_tag=3Dvirtme.initmount0 =
-machine accel=3Dkvm:tcg -watchdog i6300esb -cpu host -parallel none =
-net none -echr 1 -serial none -chardev =
stdio,id=3Dconsole,signal=3Doff,mux=3Don -serial chardev:console -mon =
chardev=3Dconsole -vga none -display none -m 2048M -smp 2 -device =
virtio-net-pci,netdev=3Dn0 -netdev user,id=3Dn0 -kernel =
.virtme/build/arch/x86/boot/bzImage -append =
'virtme_link_mods=3D.virtme/build/.virtme_mods/lib/modules/0.0.0 =
virtme_initmount0=3D/mptcp_net-next earlyprintk=3Dserial,ttyS0,115200 =
console=3DttyS0 psmouse.proto=3Dexps "virtme_stty_con=3Drows 59 cols 132 =
iutf8" TERM=3Dxterm virtme.dhcp virtme_chdir=3D/mptcp_net-next =
rootfstype=3D9p rootflags=3Dversion=3D9p2000.L,trans=3Dvirtio,access=3Dany=
 raid=3Dnoautodetect ro mitigations=3Doff init=3D/bin/sh -- -c "mount -t =
tmpfs run /run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o =
ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dany virtme.guesttools =
/run/virtme/guesttools;exec /run/virtme/guesttools/virtme-init"'
>=20
> I don't see anything about the cache and nothing in the dmesg. If you
> think this info is in the dmesg, the logs are publicly available =
there:
>=20
> https://cirrus-ci.com/task/5569063884161024?logs=3Dtest#L5626
>=20
>=20
>> Since things are slower, my first
>> suspect is the don't cache qid.version =3D=3D 0 change.  That can be
>> overridden with a mount option but perhaps we should invert the =
default
>> as it is new behavior from a linux perspective.
>=20
> Can I easily change the default behaviour on the kernel side to try
> (without modifying the tools launching the mount commands)?
>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

