Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776064;
	b=0NiOw0CJKrbBWZwIzyjgwrgfv/XGq606KwLendh5U+pCIXTOQ8aZwaQajBuqthGYfEgD
	 WFHq7iNUk7ColKD5C7bW9ntmiSrl0zkabQouWhUhYC791UiWBitgq88KT9C0LvCNaal2P
	 a1+vmCL3ExkaPHHQ5LaEh7BpQZ+JyrpCD7QA0B56sJYAaG5WPvZgY1vEBcKphPjxzDMYQ
	 VP21lAwIdLypOXgloOOEorR+k+Uxn+4r5zc7v/bT4klz9EYochii2yz+I8eI3MyZZaWob
	 0DqG1CZLio2J+ogwZWXTpIEkw+UAkPGvrpDeHsgva77yYMb4jljSq/s1T29X9DKPaPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=46jt2PFBd8rULQ4Nt62VZapADm8oEY8BfGTGabREOUM=;
	b=fpKz/SlphK6ABo8AP5VQVr6Z0H4GsTKQj5WQDvcGOEEXuIwh1+5Xn2VITznaquktAuEl
	 4IQZjS23WZqrPwqcvC7YAU6EHOFq6XGM/UzUfuHUnxIO8a95rnhFMpfOa1xZ4SYz45bKi
	 5558bxUJkfp6R/jHTdg2hmnh1q5Z+lDpa/f9WFwACAx6uwCWmTxrYnKTw7VcCYkda2POc
	 0i2EYunRSORjHMdb++T06AQssxW2PpjYgf/JwERWctdJgmMzTIzk7r+4QXSl/xKBn9qt4
	 9ODNLTMmOXPT7yylHLE9tGfwe+56Zj1T63pceTqAvs0m/kUZHnid37Q0Mus9LoBd1Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMYwIXoo;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097E606A6B1
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 10:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6097E606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMYwIXoo
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49412eb1474so5223432f8f.3
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 02:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795776063; x=1796380863; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46jt2PFBd8rULQ4Nt62VZapADm8oEY8BfGTGabREOUM=;
        b=DMYwIXooDJrp8blG+8reEZLUZeiqVqZquTiP8KWXTDH1D9ual1jqCjj3hqr/GPN+3M
         QtNDpCb1D3bfX35KuVfZm+vjdF1ERb44GbnSJ8ZLUG936SDOYh3TDejaLNkJSPZI062J
         pbaAVdDGTJ+8FUw0ycsg9hpnfx15hBHpm2ma4LDLO4KyKE4taTnBQ530+PCZh2yxsqb4
         NoKnQioiQJrisjm15my10+JMEP/9+liLg2cEGxpGO1VyJBLCIpAl2sC3gLQOcI7T/2b8
         jVrak8p1R6DTTgeaJkiRi+kA40A9LYazrgpQyQ8jjr2odmRubAs0U36s3SkpjWKgqO9o
         Rizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776063; x=1796380863;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46jt2PFBd8rULQ4Nt62VZapADm8oEY8BfGTGabREOUM=;
        b=fkcI3TrvgxZvIvtKwinxjJlFDleT1wWMHGbEP8wbrNO6REV75BBLseS/dlztwN6Z2m
         gqi7kPm/UHZMn1x2zFLZfgLm5+51VReeXHGrG2iztJpT/rdUOcmf+YwJ4TZZgvYxJgsi
         uIaNOtvD7WSf6OT+BGye2ilk8pf5lhKcXY40tIcaZceDS3dJ15tdBYZtWXbsIsLidj+x
         tvotSEP6U3U6GU8W18HfKYBr8j5M3fG0ElyM1KySsb9i+T8GFOuuxH48/LcJmDoy46P/
         O1yryNM9shhBTZN8ZEDg2rLTYCrE3BuPmyAhd9AlIFx+WVZs5Sn1yB7TCWPese2gYMVf
         LMZQ==
X-Forwarded-Encrypted: i=1; AL+hErEbHheC6FUr+GJ9U7ll+UTxeazonOB7QWWh1Elhmst9vu3Wb1CmxkhpIyM0NV4HsrmRQ9610w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+PDXPnOyErRdVVu4y+zpVpA7oRxjw+SPo+VP7+IU4OD8cyWU1g
	6S1akYoB2DJBk52S/V6tyg35/ENuMMy+4R+U24LkWatKJxT+BP3rGq7m
X-Gm-Gg: AZFdTZeseWnCn3LuK7s/HrZGwPxSsN2/zxFVp0B4k2oci+6dQbckIkpogGoiQbDQn9p
	6s7J4Na+8alGtTeMa4rNT4oT9H2hMl/0xLNRSNk0+0+qC08mQNlZv6LCMHl5ny4SFXl7sUhtBbN
	WiXMttA7x6ewwqpRV7bWDKZB6EjC7myg3K5H7IlFj89iotRXC608oidvvEjLqqMVdbX1s9/r4oc
	ZKNJ9XguxnxZc3L1WZ+N5j95TaXI5ibdHsI/BDBEAPyVSy/YCq2tr3BSe4eT8C4vjdHIoCZglgS
	rJsuqTnXp3RX/ip5K+uVDPwVHlSXGcyOg10+E9foV+0kZKXKkhAbb5ID7xoedii6+NFxRbplG5Y
	nSBS3emcueQcIGOIV/+jxLeRsxUjcAnKAr+cfVo02/3r/WVNcFx0aHHzGuPwmLAfU1AzzcRD/lT
	T622OLAFR/gbxFU5vxem6DCo7mC0GaVJaziluK8VR7QC3d9miQkBQC/DTgefjaGJvl3YlgiBiWU
	GzKU1aBR0R2UtEZNoVHNrlQtB/wFGOgcvOIpDCU8eLwYrpQCumZPxWTc8ImeVFj8kusoJ+koAFC
	8e14EsE0pk1SMWIRqDF5B3p/mBRx0PbYfs49eJDuVdSmhtJXIMFhfvTnjkBzd36Kqg==
X-Received: by 2002:a05:6000:470c:b0:4a7:593a:f421 with SMTP id ffacd0b85a97d-4abb73b557amr44307973f8f.47.1795776062532;
        Fri, 27 Nov 2026 02:41:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm47910577f8f.31.2026.11.27.02.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:41:02 -0800 (PST)
Date: Fri, 27 Nov 2026 10:41:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, David
 Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4
 fast paths
Message-ID: <20261127104100.3c915088@pumpkin>
In-Reply-To: <bffee809-2992-40eb-97c7-72d919de0aed@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
	<20261126102058.1fecf50f@pumpkin>
	<bffee809-2992-40eb-97c7-72d919de0aed@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 15:33:15 +0900
Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> On 2026/11/26 at 19:20 David Laight wrote:
> > On Tue, 24 Nov 2026 22:06:25 +0900
> > Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
> >   
> >> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >>
> >> With CONFIG_STACKPROTECTOR_STRONG=y, a function that has a local array or
> >> passes the address of one of its locals to another function needs a stack
> >> canary. The canary is set up and checked on every call, also when the
> >> local is only used on a path that almost never runs.
> >>
> >> This series removes the canary from functions of the TCP/IPv4 fast paths,
> >> by returning results by value, by using storage that is not on the stack,
> >> or by not calling a function that has nothing to do.
> >>
> >> Patch 1 returns the two mptcp_space() values in a structure, so that
> >> __tcp_select_window() no longer needs a canary.  
> > 
> > While all (I think) architectures can return a big integer in two
> > registers (dx:ax on x86), not all ABI do the same for small structures.
> > For those architectures returning a struct by value is implemented by
> > passing the address of a hidden on stack structure.
> > So code generation may be worse than passing the values by reference.
> > I can't remember the list of architectures, mostly old ones - but not
> > 32bit x86 because the compiler option was set when regparm=3 was added
> > for 2.6.
> > (Note that this is different from passing small structures by value.)
> > 
> > David  
> 
> Hi David,
> 
> Good point! thanks for bringing that up.
> 
> The small-struct-by-value pattern in patches 1 and 4 follows the same
> approach Eric used in commit 7a4cd71fa451 ("net: add
> vlan_get_protocol_offset_inline() helper"), which returns a 2-field
> struct vlan_type_depth to avoid stack canaries in callers.
> 
> I did note the 8-byte struct ABI distinction you mentioned:
> - On the main 64-bit targets (x86_64, arm64, riscv64, ppc64le, loongarch64)
>    as well as 32-bit x86 (with -mregparm=3 / reg-struct-return), both
>    8-byte structs (struct mptcp_space_info and struct skb_coalesce_res) are
>    returned in registers and the stack canaries are dropped cleanly.
> - On ABIs that return structs (> 4 bytes on 32-bit ARM EABI, or any struct
>    on s390x) via a hidden stack buffer, it indeed falls back to a hidden
>    pointer. Even there, the callers previously passed *two* pointers to
>    locals (&space/&full_space in patch 1, &fragstolen/&delta_truesize in
>    patch 4), so passing one hidden 8-byte return slot should not be worse
>    than before, while keeping the code cleaner and type-safe.

There might be a subtle difference in the function itself.
I think the result structure gets allocated on stack and then a memcpy()
used to copy that to the caller's buffer during the function return.
That may, or may not, be faster.

> 
> That said, if maintainers prefer packing the two fields into a u64 so that
> even 32-bit ARM / s390x return them in registers, I'd be happy to change
> patches 1 and 4 to do that in v2.

That is horrid ... and you'd need to use a u128 on 64bit.
It really is a shame that C doesn't have a syntax for returning 2 integers
even though pretty much all ABI have always supported it.

	David

> 
> Thanks,
> Xuanqiang

