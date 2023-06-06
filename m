Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024923C74
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 15:08:55 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-30ae4ec1ac7so4926881f8f.2
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686064133; x=1688656133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCkdSIE782UW59BfbCfIEABhddN9BVHapDENUEfuLKs=;
        b=AKxG/JHXjl8Uum2r/2E16HuYg8ZElK/c4+2yYppEnfDMT09GcxQF8AZ1vmkqWBCeqW
         L21vNgMT5QF3xoWCeWqRziuHsm/lPgieSk5KxeBranar6KckkxRluWiPkS6cOvuBxqWx
         Tn3BatCuZGabO8bXzilosw1uY844TQ0dKjvpBtP6G7QZ1SY+Ouve+PgzF3CY73meZPLs
         UabzWDGhAgW8ZPpVsVa8v4z5Bzm3EhPaMTnNrtdLdSWVjiCYxtALHMxUjfR3ApnTNt54
         fW7LQgi57ac6v/EzISldg4aM/pQiNsIkMRmVeFz+nZCF6ae0VkmSvKLNaHdl5+Ro1AVa
         YtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064133; x=1688656133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCkdSIE782UW59BfbCfIEABhddN9BVHapDENUEfuLKs=;
        b=SgIMbCg066jMIqHjtol5xcc2WYbEgzeiJXVFbWZD0YHioyiAPJoaZ3CIh2TXeQle6S
         Vn3ShesDrb/m727TQn+Nnd5mUszOgDsSQftm3zzKhSNFiGZ/nvHmTbcli8gMeYdvpErL
         /ACdN8mgeGyAPXIgHIGbqKbPScuv+XhvKFnBmMw81ee1zDU9hwA/VzdWK2eZKZv07Xuc
         PR6muKNPPQrbDq/7ZjBPQVq6RUVa71EkAKt1SrZjox5VWG/XyZyonkb3Nrodg9EITk+m
         f7yGjPJ4g7ZFAX4Mh0n14GHLwpVqWf71IvucPjO9v4t8J1ls7HdughCSklFI/bnfniKO
         B9kg==
X-Gm-Message-State: AC+VfDw+3NpEud8Mz3alveiSRkZ40FbQvnk6l+sEAQhrT2kuMuLx+Mnm
	lhz/it4losN3bsRTknrYjL0BsmYG5QdEPKbfySY=
X-Google-Smtp-Source: ACHHUZ4ACJeLA9AekLA7q5tCZJqT0l4e2TLo4lmzolw8VGOK9H3/K3o3paKZX40/czpobz8zzSd+Ww==
X-Received: by 2002:adf:ea48:0:b0:2ce:d84d:388f with SMTP id j8-20020adfea48000000b002ced84d388fmr2325882wrn.40.1686064133172;
        Tue, 06 Jun 2023 08:08:53 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:426c:bb31:d569:3738? ([2a02:578:8593:1200:426c:bb31:d569:3738])
        by smtp.gmail.com with ESMTPSA id d8-20020adff848000000b0030ae849c70csm12902830wrq.37.2023.06.06.08.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:08:52 -0700 (PDT)
Message-ID: <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net>
Date: Tue, 6 Jun 2023 17:08:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-GB
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, regressions@lists.linux.dev,
 v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 06/06/2023 16:49, Eric Van Hensbergen wrote:
> thanks for the detailed report - I=E2=80=99ll have a look.

Thank you for the quick reply!

No hurry, we can also revert these patches in our tree for the time being=
=2E

> Do you know off hand
> what cache options for 9p are in use?

Sorry, I'm not sure what to look at.

In the VM, I see that this mount command is used:

  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dan=
y \
             virtme.guesttools /run/virtme/guesttools

In virtme source, I can see these commands should be executed:

  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dan=
y \
             /dev/root /newroot/
  mount -t 9p -o version=3D9p2000.L,trans=3Dvirtio,access=3Dany \
        "virtme.initmount${tag:16}" "${!tag}"

=46rom the VM, I can see:

> # mount | grep 9p
> /dev/root on / type 9p (ro,relatime,access=3Dany,trans=3Dvirtio)
> virtme.guesttools on /run/virtme/guesttools type 9p (ro,relatime,access=
=3Dany,trans=3Dvirtio)
> virtme.initmount0 on /mptcp_net-next type 9p (rw,relatime,access=3Dany,=
trans=3Dvirtio)

And the VM is started using:

> /usr/bin/qemu-system-x86_64 -fsdev local,id=3Dvirtfs1,path=3D/,security=
_model=3Dnone,readonly=3Don,multidevs=3Dremap -device virtio-9p-pci,fsdev=
=3Dvirtfs1,mount_tag=3D/dev/root -fsdev local,id=3Dvirtfs5,path=3D/opt/vi=
rtme/virtme/guest,security_model=3Dnone,readonly=3Don,multidevs=3Dremap -=
device virtio-9p-pci,fsdev=3Dvirtfs5,mount_tag=3Dvirtme.guesttools -fsdev=
 local,id=3Dvirtfs9,path=3D.,security_model=3Dnone,multidevs=3Dremap -dev=
ice virtio-9p-pci,fsdev=3Dvirtfs9,mount_tag=3Dvirtme.initmount0 -machine =
accel=3Dkvm:tcg -watchdog i6300esb -cpu host -parallel none -net none -ec=
hr 1 -serial none -chardev stdio,id=3Dconsole,signal=3Doff,mux=3Don -seri=
al chardev:console -mon chardev=3Dconsole -vga none -display none -m 2048=
M -smp 2 -device virtio-net-pci,netdev=3Dn0 -netdev user,id=3Dn0 -kernel =
=2Evirtme/build/arch/x86/boot/bzImage -append 'virtme_link_mods=3D.virtme=
/build/.virtme_mods/lib/modules/0.0.0 virtme_initmount0=3D/mptcp_net-next=
 earlyprintk=3Dserial,ttyS0,115200 console=3DttyS0 psmouse.proto=3Dexps "=
virtme_stty_con=3Drows 59 cols 132 iutf8" TERM=3Dxterm virtme.dhcp virtme=
_chdir=3D/mptcp_net-next rootfstype=3D9p rootflags=3Dversion=3D9p2000.L,t=
rans=3Dvirtio,access=3Dany raid=3Dnoautodetect ro mitigations=3Doff init=3D=
/bin/sh -- -c "mount -t tmpfs run /run;mkdir -p /run/virtme/guesttools;/b=
in/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3Dany vi=
rtme.guesttools /run/virtme/guesttools;exec /run/virtme/guesttools/virtme=
-init"'

I don't see anything about the cache and nothing in the dmesg. If you
think this info is in the dmesg, the logs are publicly available there:

https://cirrus-ci.com/task/5569063884161024?logs=3Dtest#L5626


> Since things are slower, my first
> suspect is the don't cache qid.version =3D=3D 0 change.=C2=A0 That can =
be
> overridden with a mount option but perhaps we should invert the default=

> as it is new behavior from a linux perspective.

Can I easily change the default behaviour on the kernel side to try
(without modifying the tools launching the mount commands)?

Cheers,
Matt
--=20
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
