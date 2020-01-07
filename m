Content-Type: multipart/mixed; boundary="===============7996967979993362188=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Tue, 07 Jan 2020 16:21:48 +0100
Message-ID: <7f00d4b859864ba6a5064b9ce58bb7179e755c71.camel@redhat.com>
In-Reply-To: 574f7f93-d56a-7c73-fa3d-269480d06058@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3261

--===============7996967979993362188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-07 at 16:08 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 07/01/2020 15:05, Paolo Abeni wrote:
> > We need to update the ebpf accessors for both sk_type and
> > sk_protocol. The code previously in place has some special
> > hack to take care such fields being part of a bitfield.
> > =

> > The fix actually clean-up a bit the existing code.
> =

> Thank you for looking at that!
> =

> I have 3 questions below.
> =

> > Note: I'm not 100% sure about dropping the 'target_size' handling.
> > This changes the 'target_size' from 1 to 2 for sk_protocol.
> > Should not matter, as the ebpf target field is 4 bytes wide.
> > =

> > To be appended to the orig commit message:
> > """
> > Take care of BPF field access for sk_type/sk_protocol.
> > Both of them are now outside the bitfield, so we can use
> > load instructions without fourther shifting/masking.
> =

> (detail: s/fourther/further)
> =

> > v5 -> v6:
> >   - update eBPF accessors, too.
> > """
> > =

> > Additionally, Eric's Reviewed-by should be dropped.
> =

> Good point!
> =

> > ---
> >   include/net/sock.h | 15 ------------
> >   net/core/filter.c  | 58 ++++++++++++++++------------------------------
> >   2 files changed, 20 insertions(+), 53 deletions(-)
> > =

> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index c63e9088b4e3..8766f9bc3e70 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -436,21 +436,6 @@ struct sock {
> >   	 * Because of non atomicity rules, all
> >   	 * changes are protected by socket lock.
> >   	 */
> > -	unsigned int		__sk_flags_offset[0];
> > -#ifdef __BIG_ENDIAN_BITFIELD
> > -#define SK_FL_PROTO_SHIFT  16
> > -#define SK_FL_PROTO_MASK   0x00ff0000
> > -
> > -#define SK_FL_TYPE_SHIFT   0
> > -#define SK_FL_TYPE_MASK    0x0000ffff
> > -#else
> > -#define SK_FL_PROTO_SHIFT  8
> > -#define SK_FL_PROTO_MASK   0x0000ff00
> > -
> > -#define SK_FL_TYPE_SHIFT   16
> > -#define SK_FL_TYPE_MASK    0xffff0000
> > -#endif
> > -
> >   	u8			sk_padding : 1,
> >   				sk_kern_sock : 1,
> >   				sk_no_check_tx : 1,
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 42fd17c48c5f..37759d6ce3ea 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7607,21 +7607,19 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access=
_type type,
> >   		break;
> >   =

> >   	case offsetof(struct bpf_sock, type):
> > -		BUILD_BUG_ON(HWEIGHT32(SK_FL_TYPE_MASK) !=3D BITS_PER_BYTE * 2);
> =

> Should we not keep it?
> =

> I see that some others are still doing that:
> =

>      BUILD_BUG_ON(sizeof_field(struct sock, sk_mark) !=3D 4);

The first BUILD_BUG reported above regards only the type mask. This
patch remove such definition, so we can't keep the build bug as-is.

The second one instead is still present, via the 'bpf_target_off()'
macro call.

> But not all, e.g. for sk_state, sk_num, sk_dport.
> =

> > -		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -				      offsetof(struct sock, __sk_flags_offset));
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_AND, si->dst_reg, SK_FL_TYPE_MASK);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_RSH, si->dst_reg, SK_FL_TYPE_SHIFT);
> > -		*target_size =3D 2;
> > +		*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
> =

> Instead of BPF_H, should we use this macro?
> =

>      BPF_FIELD_SIZEOF(struct sock, sk_type)

Right u r, its' more consistent with the nearby code.

> > +				      bpf_target_off(struct sock, sk_type,
> > +						     sizeof_field(struct sock,
> > +								  sk_type),
> > +						     target_size));
> >   		break;
> >   =

> >   	case offsetof(struct bpf_sock, protocol):
> > -		BUILD_BUG_ON(HWEIGHT32(SK_FL_PROTO_MASK) !=3D BITS_PER_BYTE);
> > -		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> > -				      offsetof(struct sock, __sk_flags_offset));
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_AND, si->dst_reg, SK_FL_PROTO_MASK);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_RSH, si->dst_reg, SK_FL_PROTO_SHIFT);
> > -		*target_size =3D 1;
> > +		*insn++ =3D BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
> > +				      bpf_target_off(struct sock, sk_protocol,
> > +						     sizeof_field(struct sock,
> > +								  sk_protocol),
> > +						     target_size));
> >   		break;
> >   =

> >   	case offsetof(struct bpf_sock, src_ip4):
> > @@ -7903,20 +7901,13 @@ static u32 sock_addr_convert_ctx_access(enum bp=
f_access_type type,
> >   		break;
> >   =

> >   	case offsetof(struct bpf_sock_addr, type):
> > -		SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(
> > -			struct bpf_sock_addr_kern, struct sock, sk,
> > -			__sk_flags_offset, BPF_W, 0);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_AND, si->dst_reg, SK_FL_TYPE_MASK);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_RSH, si->dst_reg, SK_FL_TYPE_SHIFT);
> > +		SOCK_ADDR_LOAD_NESTED_FIELD(struct bpf_sock_addr_kern,
> > +					    struct sock, sk, sk_type);
> >   		break;
> >   =

> >   	case offsetof(struct bpf_sock_addr, protocol):
> > -		SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(
> > -			struct bpf_sock_addr_kern, struct sock, sk,
> > -			__sk_flags_offset, BPF_W, 0);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_AND, si->dst_reg, SK_FL_PROTO_MASK);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_RSH, si->dst_reg,
> > -					SK_FL_PROTO_SHIFT);
> > +		SOCK_ADDR_LOAD_NESTED_FIELD(struct bpf_sock_addr_kern,
> > +					    struct sock, sk, sk_protocol);
> >   		break;
> >   =

> >   	case offsetof(struct bpf_sock_addr, msg_src_ip4):
> > @@ -8835,11 +8826,11 @@ sk_reuseport_is_valid_access(int off, int size,
> >   				    skb,				\
> >   				    SKB_FIELD)
> >   =

> > -#define SK_REUSEPORT_LOAD_SK_FIELD_SIZE_OFF(SK_FIELD, BPF_SIZE, EXTRA_=
OFF) \
> > -	SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(struct sk_reuseport_kern,	\
> > -					     struct sock,		\
> > -					     sk,			\
> > -					     SK_FIELD, BPF_SIZE, EXTRA_OFF)
> > +#define SK_REUSEPORT_LOAD_SK_FIELD(SK_FIELD)				\
> > +	SOCK_ADDR_LOAD_NESTED_FIELD(struct sk_reuseport_kern,		\
> > +				    struct sock,			\
> > +				    sk,					\
> > +				    SK_FIELD)
> =

> Why did you have to change that too?

SK_REUSEPORT_LOAD_SK_FIELD_SIZE_OFF() is unused after this patch.
So I crafted another helper to make sk_protocol access easier.

> =

> >   =

> >   static u32 sk_reuseport_convert_ctx_access(enum bpf_access_type type,
> >   					   const struct bpf_insn *si,
> > @@ -8863,16 +8854,7 @@ static u32 sk_reuseport_convert_ctx_access(enum =
bpf_access_type type,
> >   		break;
> >   =

> >   	case offsetof(struct sk_reuseport_md, ip_protocol):
> > -		BUILD_BUG_ON(HWEIGHT32(SK_FL_PROTO_MASK) !=3D BITS_PER_BYTE);
> > -		SK_REUSEPORT_LOAD_SK_FIELD_SIZE_OFF(__sk_flags_offset,
> > -						    BPF_W, 0);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_AND, si->dst_reg, SK_FL_PROTO_MASK);
> > -		*insn++ =3D BPF_ALU32_IMM(BPF_RSH, si->dst_reg,
> > -					SK_FL_PROTO_SHIFT);
> > -		/* SK_FL_PROTO_MASK and SK_FL_PROTO_SHIFT are endian
> > -		 * aware.  No further narrowing or masking is needed.
> > -		 */
> > -		*target_size =3D 1;
> > +		SK_REUSEPORT_LOAD_SK_FIELD(sk_protocol);
> =

> Detail for me: why did they not modify the bitfield instead of adding =

> __sk_flags_offset[0] in include/net/sock.h ?

I guess to avoid touching a long established and delicate piece of
code. You know, you get quite serious feedback when doint that kind of
changes ;)

I'll send v1 with the cleanup hinted by the 2nd question after doing
some tests.

/P

--===============7996967979993362188==--
