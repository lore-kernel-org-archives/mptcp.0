Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7A23DB;
	Tue, 13 Jun 2023 14:56:57 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1q95S3-0004Xr-Qo; Tue, 13 Jun 2023 16:56:55 +0200
Message-ID: <4830cc62-64fd-f74b-bbfc-b8e44e023513@leemhuis.info>
Date: Tue, 13 Jun 2023 16:56:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-US, de-DE
To: evanhensbergen@icloud.com, Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>, regressions@lists.linux.dev,
 v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
 <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net>
 <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686668219;1b3a960b;
X-HE-SMSGID: 1q95S3-0004Xr-Qo

On 06.06.23 20:47, evanhensbergen@icloud.com wrote:
> Interesting - so looks like caches aren=E2=80=99t being used so curious=
 that there is any impact at all from mostly cache-related patches!
> Okay thanks, I=E2=80=99ll dig in and see what I can find.

Gentle reminder that this apparently made no progress for a week now. Or
was there progress and I just missed it? Then apologies in advance.

I'm asking, as it afaics would be nice to have this resolved in mainline
before the next -rc. That would be ideal to avoid last minute changes
after the last rc.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> On Jun 6, 2023, at 10:08 AM, Matthieu Baerts <matthieu.baerts@tessares=
=2Enet> wrote:
>>
>> Hi Eric,
>>
>> On 06/06/2023 16:49, Eric Van Hensbergen wrote:
>>> thanks for the detailed report - I=E2=80=99ll have a look.
>>
>> Thank you for the quick reply!
>>
>> No hurry, we can also revert these patches in our tree for the time be=
ing.
>>
>>> Do you know off hand
>>> what cache options for 9p are in use?
>>
>> Sorry, I'm not sure what to look at.
>>
>> In the VM, I see that this mount command is used:
>>
>>  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3D=
any \
>>             virtme.guesttools /run/virtme/guesttools
>>
>> In virtme source, I can see these commands should be executed:
>>
>>  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3D=
any \
>>             /dev/root /newroot/
>>  mount -t 9p -o version=3D9p2000.L,trans=3Dvirtio,access=3Dany \
>>        "virtme.initmount${tag:16}" "${!tag}"
>>
>> From the VM, I can see:
>>
>>> # mount | grep 9p
>>> /dev/root on / type 9p (ro,relatime,access=3Dany,trans=3Dvirtio)
>>> virtme.guesttools on /run/virtme/guesttools type 9p (ro,relatime,acce=
ss=3Dany,trans=3Dvirtio)
>>> virtme.initmount0 on /mptcp_net-next type 9p (rw,relatime,access=3Dan=
y,trans=3Dvirtio)
>>
>> And the VM is started using:
>>
>>> /usr/bin/qemu-system-x86_64 -fsdev local,id=3Dvirtfs1,path=3D/,securi=
ty_model=3Dnone,readonly=3Don,multidevs=3Dremap -device virtio-9p-pci,fsd=
ev=3Dvirtfs1,mount_tag=3D/dev/root -fsdev local,id=3Dvirtfs5,path=3D/opt/=
virtme/virtme/guest,security_model=3Dnone,readonly=3Don,multidevs=3Dremap=
 -device virtio-9p-pci,fsdev=3Dvirtfs5,mount_tag=3Dvirtme.guesttools -fsd=
ev local,id=3Dvirtfs9,path=3D.,security_model=3Dnone,multidevs=3Dremap -d=
evice virtio-9p-pci,fsdev=3Dvirtfs9,mount_tag=3Dvirtme.initmount0 -machin=
e accel=3Dkvm:tcg -watchdog i6300esb -cpu host -parallel none -net none -=
echr 1 -serial none -chardev stdio,id=3Dconsole,signal=3Doff,mux=3Don -se=
rial chardev:console -mon chardev=3Dconsole -vga none -display none -m 20=
48M -smp 2 -device virtio-net-pci,netdev=3Dn0 -netdev user,id=3Dn0 -kerne=
l .virtme/build/arch/x86/boot/bzImage -append 'virtme_link_mods=3D.virtme=
/build/.virtme_mods/lib/modules/0.0.0 virtme_initmount0=3D/mptcp_net-next=
 earlyprintk=3Dserial,ttyS0,115200 console=3DttyS0 psmouse.proto=3Dexps "=
virtme_stty_con=3Drows 59 cols 132 iutf8" TERM=3Dxterm virtme.dhcp virtme=
_chdir=3D/mptcp_net-next rootfstype=3D9p rootflags=3Dversion=3D9p2000.L,t=
rans=3Dvirtio,access=3Dany raid=3Dnoautodetect ro mitigations=3Doff init=3D=
/bin/sh -- -c "mount -t tmpfs run /run;mkdir -p /run/virtme/guesttools;/b=
in/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dany vi=
rtme.guesttools /run/virtme/guesttools;exec /run/virtme/guesttools/virtme=
-init"'
>>
>> I don't see anything about the cache and nothing in the dmesg. If you
>> think this info is in the dmesg, the logs are publicly available there=
:
>>
>> https://cirrus-ci.com/task/5569063884161024?logs=3Dtest#L5626
>>
>>
>>> Since things are slower, my first
>>> suspect is the don't cache qid.version =3D=3D 0 change.  That can be
>>> overridden with a mount option but perhaps we should invert the defau=
lt
>>> as it is new behavior from a linux perspective.
>>
>> Can I easily change the default behaviour on the kernel side to try
>> (without modifying the tools launching the mount commands)?
>>
>> Cheers,
>> Matt
>> --=20
>> Tessares | Belgium | Hybrid Access Solutions
>> www.tessares.net
>>
>=20
>=20
>=20
