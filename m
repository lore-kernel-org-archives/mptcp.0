Content-Type: multipart/mixed; boundary="===============6220990399557529015=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Patch does not apply
Date: Fri, 30 Mar 2018 12:07:46 -0700
Message-ID: <acc51422-9436-c847-2e69-b0f66e168ce0@oracle.com>
In-Reply-To: 1522434318.16359.97.camel@intel.com
X-Status: 
X-Keywords:                  
X-UID: 495

--===============6220990399557529015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/30/2018 11:25 AM, Krystad, Peter wrote:
>
>>> I think the intention with this patchset was to show how the struct prot
>>> and exposing MPTCP fully at the socket layer allows to simplify things.
>> It does  not, Look at my patch, compare and post.
> I did look at your patchset. This one has ~200 lines of code change in
> net/ipv4/*.c, a very low impact, yours is >1000. While yours has more
> functionality this one is simpler, in the sense of having less obvious
> impact to TCP code.
Hi Peter,

No offense to you and Mat.
If I were to implement the same level of functionality I would make the =

same number of changes. I can take RDS code right now and create an =

MPTCP connection. That is all this patch does.

>
>>> Creation of a real struct socket for subflows is also going to help a l=
ot,
>>> as that's the path forward to enable proper lock-separation. We can't t=
ake the
>>> meta-socket lock in the TCP-stack as I mentioned in my review to your
>>> patchset.
>>>
>>>
>>> So, in that sense for the above two points, the patchset is very useful=
 as
>>> it shows how MPTCP fits in such a model.
>> It does not show anything because it does nothing.
> I beg to differ. The point of this patchset is to show, not do. We had
> direct feedback from the netdev maintainers that "something like KCM"
> would be of interest to them, this is an attempt at that.
>
KCM, RDS do not change TCP, they use it, as it is. KCM uses eBPF instead =

of adding code to TCP. MPTCP requires mucking with TCP processing, there =

is a lot of difference. If you can use KCM than please use it, even =

better if eBPF can be used. I am not sure about direct input from =

upstream. I am aware that a statement was made "maybe we can use KCM" =

and the response was, that would be great, that is the obvious response =

because the proposal is to use an existing functionality and it is =

implied that no mucking with TCP will be done.

The code is not there. I looked at MPTCP specific processing and do not =

see any change compared to the default implementation. There is talk =

about creating an interface to push the arguments up, once you keep =

adding these small changes, we will be where we are. All the interfaces =

needed are already present and they are very clean. Just look at the Rx =

path, after my cleanup it literally has no MPTCP specific code. I can =

even narrow down the branch taken in tcp_v4_rcv.

This is getting personal and controversial so I am going to refrain from =

any other comment. If you can provide a detailed design doc that sites =

the issues and the resolution I will be happy to review it. It would =

also be good to compare the two approaches.

Regards,

Shoaib

--===============6220990399557529015==--
